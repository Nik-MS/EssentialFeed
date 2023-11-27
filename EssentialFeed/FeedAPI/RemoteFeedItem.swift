//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 11/27/23.
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
