//
//  FeedPresenterTests.swift
//  EssentialFeedTests
//
//  Created by Nikhil Menon on 2/21/24.
//

import XCTest

final class FeedPresenter {
    init(view: Any) {
        
    }
}

final class FeedPresenterTests: XCTestCase {
    
    func test_init_doesNotSendMessagesToView() {
        let view = ViewSpy()
        
        _ = FeedPresenter(view: view)
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    // MARK: - Helpers
    
    private class ViewSpy {
        let messages = [Any]()
    }

}
