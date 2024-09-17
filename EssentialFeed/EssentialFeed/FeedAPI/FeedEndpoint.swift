//
//  FeedEndpoint.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 9/16/24.
//

import Foundation

public enum FeedEndpoint {
    case get
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case .get:
            return baseURL.appending(path: "/v1/feed")
        }
    }
}
