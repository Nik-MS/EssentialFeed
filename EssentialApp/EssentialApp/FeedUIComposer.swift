//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 1/30/24.
//

import UIKit
import EssentialFeed
import EssentialFeediOS
import Combine

public final class FeedUIComposer {
    private init() { }
    
    public static func feedComposedWith(
        feedLoader: @escaping () -> AnyPublisher<[FeedImage], Swift.Error>,
        imageLoader: @escaping(URL) -> FeedImageDataLoader.Publisher) -> ListViewController {
        let presentationAdapter = LoadResourcePresentationAdapter<[FeedImage], FeedViewAdapter>(
            loader: feedLoader)
        let feedController = makeFeedViewController(title: FeedPresenter.title)
        feedController.onRefresh = presentationAdapter.loadResource
        
        let weakFeedController = WeakRefVirtualProxy(feedController)
        let presenter = LoadResourcePresenter(
            resourceView: FeedViewAdapter(
                controller: feedController,
                imageLoader: { imageLoader($0).dispatchOnMainQueue() }),
            loadingView: weakFeedController,
            errorView: weakFeedController,
            mapper: FeedPresenter.map(_:)
        )
        
        presentationAdapter.presenter = presenter
        
        return feedController
    }
    
    private static func makeFeedViewController(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! ListViewController
        feedController.title = title
        return feedController
    }
}
