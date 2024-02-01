//
//  FeedImageCellController.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 1/30/24.
//

import UIKit
import EssentialFeed

final class FeedImageCellController {
    private let viewModel: FeedImageViewModel
    
    init(viewModel: FeedImageViewModel) {
        self.viewModel = viewModel
    }
    
    func view() -> UITableViewCell {
        let cell = FeedImageCell()
        cell.locationContainer.isHidden = !viewModel.hasLocation
        cell.locationLabel.text = viewModel.location
        cell.descriptionLabel.text = viewModel.description
        cell.onRetry = viewModel.loadImage
        
        cell.feedImageView.image = nil
        cell.feedImageRetryButton.isHidden = true
        
        
        cell.feedImageContainer.startShimmering()
        
        viewModel.onLoadingStateChange = { [weak cell] state in
            cell?.feedImageContainer.stopShimmering()
            
            switch state {
            case .loading:
                cell?.feedImageContainer.startShimmering()
                cell?.feedImageRetryButton.isHidden = true
            case .loaded(let image):
                cell?.feedImageView.image = image
                cell?.feedImageRetryButton.isHidden = true
            case .failed:
                cell?.feedImageRetryButton.isHidden = false
            }
        }
        
        viewModel.loadImage()
        return cell
    }
    
    func preload() {
        viewModel.preload()
    }
    
    func cancelLoad() {
        viewModel.cancelLoad()
    }
}
