//
//  FeedUIIntegrationTests+Localization.swift
//  EssentialFeediOSTests
//
//  Created by Nikhil Menon on 2/13/24.
//

import UIKit
import EssentialFeed
import XCTest

extension FeedUIIntegrationTests {
    private class DummyView: ResourceView {
        func display(_ viewModel: Any) { }
    }
    
    var loadError: String { LoadResourcePresenter<Any, DummyView>.loadError }
    var feedTitle: String { FeedPresenter.title }
    
    // MARK: - Comments
    var commentsTitle: String { ImageCommentsPresenter.title }
}
