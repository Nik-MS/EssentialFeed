//
//  FeedImageDataLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Nikhil Menon on 6/8/24.
//

import EssentialFeed

public final class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private let decoratee: FeedImageDataLoader
    private let cache: FeedImageDataCache
    
    public init(decoratee: FeedImageDataLoader, cache: FeedImageDataCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func loadImageData(from url: URL, completion: @escaping ((Result<Data, any Error>) -> Void)) -> any EssentialFeed.FeedImageDataLoaderTask {
        return decoratee.loadImageData(from: url) { [weak self] result in
            completion(
                result.map {
                    self?.cache.saveIgnoringResult($0, for: url)
                    return $0
                }
            )
        }
    }
}

fileprivate extension FeedImageDataCache {
    func saveIgnoringResult(_ data: Data, for url: URL) {
        save(data, for: url) { _ in }
    }
}
