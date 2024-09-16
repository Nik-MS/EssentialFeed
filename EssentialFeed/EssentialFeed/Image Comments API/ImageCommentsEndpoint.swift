//
//  ImageCommentsEndpoint.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 9/16/24.
//

import Foundation

public enum ImageCommentsEndpoint {
    case get(UUID)
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case let .get(id):
            return baseURL.appending(path: "/v1/image/\(id)/comments")
        }
    }
}
