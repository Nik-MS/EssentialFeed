//
//  ListViewController+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Nikhil Menon on 2/13/24.
//

import UIKit
@testable import EssentialFeediOS

extension ListViewController {
    override public func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        tableView.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        tableView.numberOfSections > section ? tableView.numberOfRows(inSection: section) : 0
    }
    
    private func cell(row: Int, section: Int) -> UITableViewCell? {
        guard numberOfRenderedFeedImageViews() > row else { return nil }
        
        let ds = tableView.dataSource
        let indexPath = IndexPath(row: row, section: section)
        return ds?.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func simulateUserInitiatedReload() {
        refreshControl?.simulatePullToRefresh()
    }
    
    func simulateErrorViewTap() {
        errorView.simulateTap()
    }
    
    func simulateTapOnFeedImage(at row: Int) {
        let delegate = tableView.delegate
        let indexPath = IndexPath(row: row, section: feedImagesSection)
        delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    var errorMessage: String? {
        return errorView.message
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

// MARK: - Feed

extension ListViewController {
    
    func feedImageView(at row: Int) -> UITableViewCell? {
        cell(row: row, section: feedImagesSection)
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
        numberOfRows(inSection: feedImagesSection)
    }
    
    private var feedImagesSection: Int { 0 }
    
    
}

// MARK: - Comments

extension ListViewController {
    func numberOfRenderedComments() -> Int {
        numberOfRows(inSection: commentsSection)
    }
    
    var commentsSection: Int { 0 }
    
    func commentMessage(at row: Int) -> String? {
        commentView(at: row)?.messageLabel.text
    }
    
    func commentDate(at row: Int) -> String? {
        commentView(at: row)?.dateLabel.text
    }
    
    func commentUsername(at row: Int) -> String? {
        commentView(at: row)?.usernameLabel.text
    }
    
    private func commentView(at row: Int) -> ImageCommentCell? {
        cell(row: row, section: commentsSection) as? ImageCommentCell
    }
}

