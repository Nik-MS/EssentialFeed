//
//  ImageCommentsMapperTests.swift
//  EssentialFeedTests
//
//  Created by Nikhil Menon on 7/17/24.
//

import XCTest
import EssentialFeed

final class ImageCommentsMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon2xxHTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 150, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(try ImageCommentsMapper.map(json, from: .init(statusCode: code)))
        }
    }
    
    func test_map_throwsErrorOnNon2xxHTTPResponseWithInvalidJSON() throws {
        let samples = [200, 201, 250, 280, 299]
        let invalidJSON = Data("invalid json".utf8)
        
        try samples.forEach { code in
            XCTAssertThrowsError(try ImageCommentsMapper.map(invalidJSON, from: .init(statusCode: code)))
        }
    }
    
    func test_map_deliversNoItemsOn2xxHTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeItemsJSON([])
        let samples = [200, 201, 250, 280, 299]
        
        try samples.forEach { code in
            let result = try ImageCommentsMapper.map(emptyListJSON, from: .init(statusCode: code))
            XCTAssertEqual(result, [])
        }
    }
    
    func test_load_deliversItemsOn2xxHTTPResponseWithJSONItems() throws {
        let item1 = makeItem(
            id: UUID(),
            message: "a message",
            createdAt: (Date(timeIntervalSince1970: 1598627222), "2020-08-28T15:07:02+00:00"),
            username: "a username")
        
        
        let item2 = makeItem(
            id: UUID(),
            message: "another message",
            createdAt: (Date(timeIntervalSince1970: 1577881882), "2020-01-01T12:31:22+00:00"),
            username: "another username")
        
        let itemsJSON = makeItemsJSON([item1.json, item2.json])
        let items = [item1.model, item2.model]
        
        let samples = [200, 201, 250, 280, 299]
        
        try samples.forEach { code in
            let result = try ImageCommentsMapper.map(itemsJSON, from: .init(statusCode: code))
            XCTAssertEqual(result, items)
        }
    }
    
    // MARK: - Helpers
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let json = [ "items": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makeItem(id: UUID, message: String, createdAt: (date: Date, iso8601String: String), username: String) -> (model: ImageComment, json: [String: Any]) {
        let item = ImageComment(id: id, message: message, createdAt: createdAt.date, username: username)
        let json: [String: Any] = [
            "id": id.uuidString,
            "message": message,
            "created_at": createdAt.iso8601String,
            "author": [
                "username": username
            ]
        ]
        
        return (item, json)
    }

}
