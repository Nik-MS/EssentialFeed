//
//  FeedPresenter.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 2/21/24.
//

import Foundation

public protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

public final class FeedPresenter {
    private let feedView: FeedView
    private let loadingView: ResourceLoadingView
    private let errorView: ResourceErrorView
    
    private var feedLoadError: String {
        NSLocalizedString("GENERIC_CONNECTION_ERROR",
                          tableName: "Shared",
                          bundle: Bundle(for: FeedPresenter.self),
                          comment: "Error message displayed when we can't load image feed from the server.")
    }
    
    public static var title: String {
        NSLocalizedString("FEED_VIEW_TITLE", tableName: "Feed", bundle: Bundle(for: FeedPresenter.self), comment: "Title for the feed view")
    }
    
    public static func map(_ feed: [FeedImage]) -> FeedViewModel {
        FeedViewModel(feed: feed)
    }

    public init(feedView: FeedView, loadingView: ResourceLoadingView, errorView: ResourceErrorView) {
        self.feedView = feedView
        self.loadingView = loadingView
        self.errorView = errorView
    }
    
    public func didStartLoadingFeed() {
        errorView.display(.noError)
        loadingView.display(.init(isLoading: true))
    }
    
    public func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(Self.map(feed))
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoadingFeed(with error: Error) {
        errorView.display(.error(message: feedLoadError))
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
    }
}
