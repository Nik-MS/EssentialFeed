//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 1/31/24.
//

import Foundation
import UIKit

public struct FeedImageViewModel<Image> {
    public var description: String?
    public var location: String?
    public let image: Image?
    public let isLoading: Bool
    public let shouldRetry: Bool
    
    public var hasLocation: Bool {
        return location != nil
    }
}
