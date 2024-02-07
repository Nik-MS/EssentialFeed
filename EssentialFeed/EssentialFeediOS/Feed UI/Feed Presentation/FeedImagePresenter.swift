//
//  FeedImagePresenter.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 2/6/24.
//

import Foundation
import EssentialFeed

protocol FeedImageView {
    associatedtype Image
    func display(_ viewModel: FeedImageViewModel<Image>)
}

final class FeedImagePresenter<View: FeedImageView, Image> where View.Image == Image {
    private let imageTransformer: ((Data)) -> Image?
    
    private let view: View
    
    init(view: View, imageTransformer: @escaping (Data) -> Image?) {
        self.imageTransformer = imageTransformer
        self.view = view
    }
    
    private struct InvalidImageDataError: Error { }
    
    func didStartLoadingImageData(for model: FeedImage) {
        view.display(FeedImageViewModel(
            description: model.description,
            location: model.location,
            image: nil,
            isLoading: true,
            shouldRetry: false)
        )
    }
    
    func didFinishLoadingImageData(with data: Data, for model: FeedImage) {
        guard let image = imageTransformer(data) else {
            return didFinishLoadingImageData(with: InvalidImageDataError(), for: model)
        }
        
        view.display(FeedImageViewModel(
            description: model.description,
            location: model.location,
            image: image,
            isLoading: false,
            shouldRetry: false)
        )
    }
    
    func didFinishLoadingImageData(with error: Error, for model: FeedImage) {
        view.display(FeedImageViewModel(
            description: model.description,
            location: model.location,
            image: nil,
            isLoading: false,
            shouldRetry: true)
        )
    }
}
