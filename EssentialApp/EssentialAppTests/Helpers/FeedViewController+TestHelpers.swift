//
//  FeedViewController+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Nikhil Menon on 2/13/24.
//

import UIKit
import EssentialFeediOS

extension FeedViewController {
    func feedImageView(at index: Int) -> UITableViewCell? {
        let ds = tableView.dataSource
        let indexPath = IndexPath(row: index, section: feedImagesSection)
        return ds?.tableView(tableView, cellForRowAt: indexPath)
    }
    
    @discardableResult
    func simulateFeedImageViewVisible(at index: Int) -> FeedImageCell? {
        let view = feedImageView(at: index) as? FeedImageCell
        return view
    }
    
    func renderedFeedImageData(at index: Int) -> Data? {
        simulateFeedImageViewVisible(at: index)?.renderedImage
    }
    
    @discardableResult
    func simulateFeedImageViewNotVisible(at row: Int) -> FeedImageCell? {
        let view = simulateFeedImageViewVisible(at: row)
        let delegate = tableView.delegate
        let indexPath = IndexPath(row: row, section: feedImagesSection)
        delegate?.tableView?(tableView, didEndDisplaying: view!, forRowAt: indexPath)
        return view
    }
    
    func simulateFeedImageViewNearVisible(at index: Int) {
        let ds = tableView.prefetchDataSource
        let indexPath = IndexPath(row: index, section: feedImagesSection)
        ds?.tableView(tableView, prefetchRowsAt: [indexPath])
    }
    
    func simulateFeedImageViewNotNearVisible(at index: Int) {
        simulateFeedImageViewNearVisible(at: index)
        
        let ds = tableView.prefetchDataSource
        let indexPath = IndexPath(row: index, section: feedImagesSection)
        ds?.tableView?(tableView, cancelPrefetchingForRowsAt: [indexPath])
    }
    
    func numberOfRenderedFeedImageViews() -> Int {
        return tableView.numberOfRows(inSection: feedImagesSection)
    }
    
    private var feedImagesSection: Int { 0 }
    
    func simulateUserInitiatedFeedReload() {
        refreshControl?.simulatePullToRefresh()
    }
    
    var errorMessage: String? {
        return errorView?.message
    }
    
    var isShowingLoadingIndicator: Bool {
        return refreshControl?.isRefreshing == true
    }
    
    func simulateAppearance() {
        if !isViewLoaded {
            loadViewIfNeeded()
            replaceRefreshControlIfNeeded()
        }
        
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
    
    func replaceRefreshControlIfNeeded() {
        let fakeRefreshControl = FakeRefreshContol()
        
        self.refreshControl?.allTargets.forEach { target in
            self.refreshControl?.actions(forTarget: target, forControlEvent: .valueChanged)?.forEach {
                fakeRefreshControl.addTarget(target, action: Selector($0), for: .valueChanged)
            }
        }
        
        self.refreshControl = fakeRefreshControl
        self.refreshControl = self.refreshControl
    }
}
