//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 11/4/23.
//

import Foundation

internal final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [Item]
        
        var feed: [FeedItem] {
            items.map(\.item)
        }
    }

    // This struct is the same as a FeedItem, except that
    // `imageURL` is now `image`. This is to keep decoding logic isolated.
    // RemoteFeedLoader expects a JSON property with name, `imageURL`. But what if
    // another module expects the image property to be named `profilePic`?

    // An internal model for the internal API module.
    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL
        
        var item: FeedItem {
            FeedItem(id: id, description: description, location: location, imageURL: image)
        }
    }
    
    private static var OK_200: Int { return 200 }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(RemoteFeedLoader.Error.invalidData)
              }
        
        return .success(root.feed)
    }
}
