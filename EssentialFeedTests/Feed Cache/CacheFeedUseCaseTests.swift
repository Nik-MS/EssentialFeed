//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Nikhil Menon on 11/20/23.
//

import XCTest

class LocalFeedLoader {
    init(store: FeedStore) {
        
    }
}

/// FeedStore is a helper class representing the framework side to help us
/// define the abstract interface that the use case needs for its collaborator, making sure not to leak
/// framework details into the use case.
class FeedStore {
    var deleteCachedFeedCallCount = 0
}

final class CacheFeedUseCaseTests: XCTestCase {
    
    func test_init_doesNotDelegateCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }
}
