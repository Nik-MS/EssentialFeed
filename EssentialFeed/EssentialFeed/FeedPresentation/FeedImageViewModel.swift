//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 1/31/24.
//

import Foundation

public struct FeedImageViewModel {
    public var description: String?
    public var location: String?
    
    public var hasLocation: Bool {
        return location != nil
    }
}
