//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 1/31/24.
//

import Foundation
import UIKit
import EssentialFeed

struct FeedImageViewModel<Image> {
    var description: String?
    var location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
