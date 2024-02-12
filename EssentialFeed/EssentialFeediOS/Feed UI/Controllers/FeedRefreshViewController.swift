//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 1/30/24.
//

import UIKit

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

public final class FeedRefreshViewController: NSObject, FeedLoadingView {
    @IBOutlet public var view: UIRefreshControl?
    
    internal var delegate: FeedRefreshViewControllerDelegate?
    
    @IBAction internal func refresh() {
        delegate?.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
}
