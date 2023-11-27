//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 11/4/23.
//


import Foundation

// This struct is the same as a FeedItem, except that
// `imageURL` is now `image`. This is to keep decoding logic isolated.
// RemoteFeedLoader expects a JSON property with name, `imageURL`. But what if
// another module expects the image property to be named `profilePic`?

// An internal model for the internal API module.
internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}

internal final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }
    
    private static var OK_200: Int { return 200 }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        return root.items
    }
}
