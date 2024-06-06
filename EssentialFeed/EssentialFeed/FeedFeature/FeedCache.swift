//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 6/6/24.
//

import Foundation

public protocol FeedCache {
    typealias SaveResult = Swift.Result<Void, Error>
    
    func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void)
}
