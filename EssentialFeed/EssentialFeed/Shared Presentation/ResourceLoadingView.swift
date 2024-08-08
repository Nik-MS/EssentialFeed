//
//  ResourceLoadingView.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 8/3/24.
//

import Foundation

public protocol ResourceLoadingView {
    func display(_ viewModel: ResourceLoadingViewModel)
}

public struct ResourceLoadingViewModel {
    public let isLoading: Bool
}
