//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 1/31/24.
//

import Foundation
import UIKit
import EssentialFeed

final class FeedImageViewModel {
    private var task: FeedImageDataLoaderTask?
    private let model: FeedImage
    private let imageLoader: FeedImageDataLoader
    
    init(model: FeedImage, imageLoader: FeedImageDataLoader) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    var description: String? {
        return model.description
    }
    
    var location: String? {
        return model.location
    }
    
    var hasLocation: Bool {
        return location != nil
    }
    
    enum LoadingState {
        case loading
        case loaded(UIImage)
        case failed
    }
    
    var onImageLoad: ((UIImage) -> Void)?
    var onLoadingStateChange: ((LoadingState) -> Void)?
    
    func loadImage() {
        onLoadingStateChange?(.loading)
        task = imageLoader.loadImageData(from: model.url) { [weak self] result in
            self?.handle(result)
        }
    }
    
    func preload() {
        loadImage()
    }
    
    func cancelLoad() {
        task?.cancel()
        task = nil
    }
    
    private func handle(_ result: FeedImageDataLoader.Result) {
        if let image = (try? result.get()).flatMap(UIImage.init) {
            onLoadingStateChange?(.loaded(image))
        } else {
            onLoadingStateChange?(.failed)
        }
    }
}
