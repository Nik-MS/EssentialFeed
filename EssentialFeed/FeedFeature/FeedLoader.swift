//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 9/2/23.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
