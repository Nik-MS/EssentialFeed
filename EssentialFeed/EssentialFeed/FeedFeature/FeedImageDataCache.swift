//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 6/8/24.
//

import Foundation

public protocol FeedImageDataCache {
    typealias SaveResult = Swift.Result<Void, Error>
    
    func save(_ data: Data, for url: URL, completion: @escaping (SaveResult) -> Void)
}
