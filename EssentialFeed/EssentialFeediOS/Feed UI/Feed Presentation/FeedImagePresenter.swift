//
//  FeedImagePresenter.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 2/6/24.
//

import Foundation
import EssentialFeed

public protocol FeedImageView {
    associatedtype Image
    func display(_ viewModel: FeedImageViewModel<Image>)
}

final public class FeedImagePresenter<View: FeedImageView, Image> where View.Image == Image {
    private let imageTransformer: ((Data)) -> Image?
    
    private let view: View
    
    public init(view: View, imageTransformer: @escaping (Data) -> Image?) {
        self.imageTransformer = imageTransformer
        self.view = view
    }
    
    private struct InvalidImageDataError: Error { }
    
    public func didStartLoadingImageData(for model: FeedImage) {
        view.display(FeedImageViewModel(
            description: model.description,
            location: model.location,
            image: nil,
            isLoading: true,
            shouldRetry: false)
        )
    }
    
    public func didFinishLoadingImageData(with data: Data, for model: FeedImage) {
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
    
    public func didFinishLoadingImageData(with error: Error, for model: FeedImage) {
        view.display(FeedImageViewModel(
            description: model.description,
            location: model.location,
            image: nil,
            isLoading: false,
            shouldRetry: true)
        )
    }
}
