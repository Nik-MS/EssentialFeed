//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 9/26/23.
//

import Foundation

public typealias RemoteFeedLoader = RemoteLoader<[FeedImage]>

public extension RemoteFeedLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: FeedItemsMapper.map)
    }
}
