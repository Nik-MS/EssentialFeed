//
//  FeedViewAdapter.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 2/13/24.
//

import UIKit
import EssentialFeed
import EssentialFeediOS

final class FeedViewAdapter: ResourceView {
    private weak var controller: FeedViewController?
    private let imageLoader: (URL) -> FeedImageDataLoader.Publisher
    
    init(controller: FeedViewController?, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.display(viewModel.feed.map(composeCellController(with:)))
    }
    
    private func composeCellController(with model: FeedImage) -> FeedImageCellController {
        let adapter: LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<FeedImageCellController>> = .init { [imageLoader] in
            imageLoader(model.url)
        }
        
        let view = FeedImageCellController(
            viewModel: FeedImagePresenter<FeedImageCellController, UIImage>.map(model),
            delegate: adapter)
        
        adapter.presenter = LoadResourcePresenter<Data, WeakRefVirtualProxy<FeedImageCellController>>(
            resourceView: WeakRefVirtualProxy(view),
            loadingView: WeakRefVirtualProxy(view),
            errorView: WeakRefVirtualProxy(view),
            mapper: { data in
                guard let image = UIImage(data: data) else {
                    throw InvalidImageData()
                }
                
                return image
            }
        )
        
        return view
    }
}

struct InvalidImageData: Error { }
