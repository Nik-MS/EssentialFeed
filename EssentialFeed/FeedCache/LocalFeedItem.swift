//
//  LocalFeedItem.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 11/27/23.
//

import Foundation

// Looks like we are duplicating code, but this struct may have different reasons to changes versus
// the original FeedItem. By copying, we allow both FeedItem and LocalFeedItem to change at their own pace.
// This technique is called a Data Transfer Object.
public struct LocalFeedItem: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
    
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}
