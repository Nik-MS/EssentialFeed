//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 9/26/23.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}

public final class RemoteFeedLoader {
    private let url: URL
    // RemoteFeedLoader does not need to locate or instantiate HTTPClient instance.
    // Instead, we make our code more modular by injecting as a dependency.
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
        client.get(from: url)
    }
}
