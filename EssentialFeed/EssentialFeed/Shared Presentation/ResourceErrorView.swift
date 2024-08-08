//
//  ResourceErrorView.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 8/3/24.
//

import Foundation

public protocol ResourceErrorView {
    func display(_ viewModel: ResourceErrorViewModel)
}

public struct ResourceErrorViewModel {
    public let message: String?
    
    static var noError = ResourceErrorViewModel(message: nil)
    
    static func error(message: String) -> ResourceErrorViewModel {
        return ResourceErrorViewModel(message: message)
    }
}

