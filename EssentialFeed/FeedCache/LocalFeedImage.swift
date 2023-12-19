//
//  LocalFeedImage.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 11/27/23.
//

import Foundation

// Looks like we are duplicating code, but this struct may have different reasons to changes versus
// the original FeedItem. By copying, we allow both FeedItem and LocalFeedImage to change at their own pace.
// This technique is called a Data Transfer Object.
public struct LocalFeedImage: Equatable, Codable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL
    
    public init(id: UUID, description: String?, location: String?, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
}
