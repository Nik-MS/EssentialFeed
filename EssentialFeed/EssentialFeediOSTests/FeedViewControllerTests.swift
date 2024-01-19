//
//  FeedViewControllerTests.swift
//  EssentialFeediOSTests
//
//  Created by Nikhil Menon on 1/19/24.
//

import XCTest
import UIKit
import EssentialFeed

class FeedViewController: UIViewController {
    private var loader: LoaderSpy?
    
    convenience init(loader: LoaderSpy) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader?.load()
    }
}

final class FeedViewControllerTests: XCTestCase {

    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        let _ = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }
    
    func test_viewDidLoad_loadsFeed() {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadCallCount, 1)
    }
}

class LoaderSpy {
    private(set) var loadCallCount: Int = 0
    
    func load() {
        loadCallCount += 1
    }
}
