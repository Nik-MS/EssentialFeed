//
//  FeedImageCell.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 1/24/24.
//

import UIKit

public final class FeedImageCell: UITableViewCell {
    @IBOutlet private(set) var locationContainer: UIView!
    @IBOutlet private(set) var locationLabel: UILabel!
    @IBOutlet private(set) var descriptionLabel: UILabel!
    @IBOutlet private(set) var feedImageContainer: UIView!
    @IBOutlet private(set) var feedImageView: UIImageView!
    
    @IBOutlet private(set) var feedImageRetryButton: UIButton!
        
    var onRetry: (() -> Void)?
    
    @IBAction private func retryButtonTapped() {
        onRetry?()
    }
}
