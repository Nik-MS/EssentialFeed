//
//  FeedErrorViewModel.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 2/20/24.
//

import Foundation

struct FeedErrorViewModel {
    let message: String?
    
    static var noError = FeedErrorViewModel(message: nil)
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
