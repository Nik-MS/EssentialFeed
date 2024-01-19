//
//  FeedViewControllerTests.swift
//  EssentialFeediOSTests
//
//  Created by Nikhil Menon on 1/19/24.
//

import XCTest
import EssentialFeed

class FeedViewController {
    
    private let loader: LoaderSpy
    
    init(loader: LoaderSpy) {
        self.loader = loader
    }
}

final class FeedViewControllerTests: XCTestCase {

    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        let _ = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }
}

class LoaderSpy {
    private(set) var loadCallCount: Int = 0
}
