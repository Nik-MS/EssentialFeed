//
//  FeedImageDataLoaderWithFallbackComposite.swift
//  EssentialApp
//
//  Created by Nikhil Menon on 6/5/24.
//

import Foundation
import EssentialFeed

public class FeedImageDataLoaderWithFallbackComposite: FeedImageDataLoader {
    let primary: FeedImageDataLoader
    let fallback: FeedImageDataLoader
    
    public init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    private class TaskWrapper: FeedImageDataLoaderTask {
        var wrapped: FeedImageDataLoaderTask?
        
        func cancel() {
            wrapped?.cancel()
        }
    }
    
    public func loadImageData(from url: URL, completion: @escaping ((Result<Data, any Error>) -> Void)) -> FeedImageDataLoaderTask {
        let taskWrapper = TaskWrapper()
        let primaryTask  = primary.loadImageData(from: url) { [weak self] result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                let fallbackTask = self?.fallback.loadImageData(from: url, completion: completion)
                taskWrapper.wrapped = fallbackTask
            }
        }
        
        taskWrapper.wrapped = primaryTask
        return taskWrapper
    }
}
