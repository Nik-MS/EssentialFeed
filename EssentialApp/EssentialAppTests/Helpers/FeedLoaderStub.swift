//
//  FeedLoaderStub.swift
//  EssentialAppTests
//
//  Created by Nikhil Menon on 6/6/24.
//

import Foundation
import EssentialFeed


class FeedLoaderStub {
    private let result: Swift.Result<[FeedImage], Error>
    
    init(result: Swift.Result<[FeedImage], Error>) {
        self.result = result
    }
    
    func load(completion: @escaping (Result<[EssentialFeed.FeedImage], any Error>) -> Void) {
        completion(result)
    }
}
