//
//  FeedLoaderStub.swift
//  EssentialAppTests
//
//  Created by Nikhil Menon on 6/6/24.
//

import Foundation
import EssentialFeed


class FeedLoaderStub: FeedLoader {
    private let result: FeedLoader.Result
    
    init(result: FeedLoader.Result) {
        self.result = result
    }
    
    func load(completion: @escaping (Result<[EssentialFeed.FeedImage], any Error>) -> Void) {
        completion(result)
    }
}
