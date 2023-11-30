//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 9/2/23.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
