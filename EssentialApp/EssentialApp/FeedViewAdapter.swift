//
//  FeedViewAdapter.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 2/13/24.
//

import UIKit
import EssentialFeed
import EssentialFeediOS

final class FeedViewAdapter: FeedView {
    private weak var controller: FeedViewController?
    private let imageLoader: FeedImageDataLoader
    
    init(controller: FeedViewController?, imageLoader: FeedImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.display(viewModel.feed.map { model in
            let adapter = FeedImageDataLoaderPresentationAdapter<WeakRefVirtualProxy<FeedImageCellController>, UIImage>(model: model, imageLoader: imageLoader)
            let view = FeedImageCellController(delegate: adapter)
            let weakView = WeakRefVirtualProxy(view)
            adapter.presenter = FeedImagePresenter(view: weakView, imageTransformer: UIImage.init)
            return view
        })
    }
}
