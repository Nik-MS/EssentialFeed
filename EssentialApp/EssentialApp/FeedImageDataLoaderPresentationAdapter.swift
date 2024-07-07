//
//  FeedImageDataLoaderPresentationAdapter.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 2/13/24.
//

import EssentialFeed
import EssentialFeediOS
import Combine

final class FeedImageDataLoaderPresentationAdapter<View: FeedImageView, Image>: FeedImageCellControllerDelegate where Image == View.Image {
    private let model: FeedImage
    private let imageLoader: (URL) -> FeedImageDataLoader.Publisher
    private var task: FeedImageDataLoaderTask?
    private var cancellable: Cancellable?
    
    
    public var presenter: FeedImagePresenter<View, Image>?
    
    init(model: FeedImage, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    func didRequestImage() {
        presenter?.didStartLoadingImageData(for: model)
        let model = self.model
        
        cancellable = imageLoader(model.url).sink { [weak self] completion in
            if case let .failure(error) = completion {
                self?.presenter?.didFinishLoadingImageData(with: error, for: model)
            }
            
        } receiveValue: { [weak self] data in
            self?.presenter?.didFinishLoadingImageData(with: data, for: model)
        }
    }
    
    func didCancelImageRequest() {
        cancellable?.cancel()
    }
    
    private func handle(_ result: FeedImageDataLoader.Result) {
        switch result {
        case let .success(data):
            self.presenter?.didFinishLoadingImageData(with: data, for: model)
        case let .failure(error):
            self.presenter?.didFinishLoadingImageData(with: error, for: model)
        }
    }
}
