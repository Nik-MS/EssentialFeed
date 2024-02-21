//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 2/21/24.
//

import Foundation

public struct FeedErrorViewModel {
    public let message: String?
    
    static var noError = FeedErrorViewModel(message: nil)
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
