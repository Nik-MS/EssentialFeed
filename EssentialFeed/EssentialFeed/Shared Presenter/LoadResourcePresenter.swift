//
//  LoadResourcePresenter.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 7/31/24.
//

import Foundation

public protocol ResourceView {
    func display(_ viewModel: String)
}

public final class LoadResourcePresenter {
    public typealias Mapper = (String) -> String
    private let mapper: Mapper
    private let resourceView: ResourceView
    private let loadingView: FeedLoadingView
    private let errorView: FeedErrorView
    
    private var feedLoadError: String {
        NSLocalizedString("FEED_VIEW_CONNECTION_ERROR",
                          tableName: "Feed",
                          bundle: Bundle(for: FeedPresenter.self),
                          comment: "Error message displayed when we can't load image feed from the server.")
    }

    public init(resourceView: ResourceView, loadingView: FeedLoadingView, errorView: FeedErrorView, mapper: @escaping Mapper) {
        self.resourceView = resourceView
        self.loadingView = loadingView
        self.errorView = errorView
        self.mapper = mapper
    }
    
    public func didStartLoading() {
        errorView.display(.noError)
        loadingView.display(.init(isLoading: true))
    }
    
    public func didFinishLoading(with resource: String) {
        resourceView.display(mapper(resource))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoadingFeed(with error: Error) {
        errorView.display(.error(message: feedLoadError))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
