//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 9/26/23.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public final class RemoteFeedLoader {
    private let url: URL
    // RemoteFeedLoader does not need to locate or instantiate HTTPClient instance.
    // Instead, we make our code more modular by injecting as a dependency.
    private let client: HTTPClient
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .success:
                completion(.failure(.invalidData))
            case .failure(_):
                completion(.failure(.connectivity))
            }
        }
    }
}
