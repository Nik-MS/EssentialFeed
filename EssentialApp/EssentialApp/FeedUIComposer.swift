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
        imageLoader: @escaping(URL) -> FeedImageDataLoader.Publisher) -> FeedViewController {
        let presentationAdapter = FeedLoaderPresentationAdapter(
            feedLoader: { feedLoader().dispatchOnMainQueue() })
        let feedController = makeFeedViewController(delegate: presentationAdapter, title: FeedPresenter.title)
        
        let weakFeedController = WeakRefVirtualProxy(feedController)
        let presenter = FeedPresenter(
            feedView: FeedViewAdapter(
                controller: feedController,
                imageLoader: { imageLoader($0).dispatchOnMainQueue() }),
            loadingView: weakFeedController,
            errorView: weakFeedController
        )
        
        presentationAdapter.presenter = presenter
        
        return feedController
    }
    
    private static func makeFeedViewController(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
        feedController.delegate = delegate
        feedController.title = title
        return feedController
    }
}
