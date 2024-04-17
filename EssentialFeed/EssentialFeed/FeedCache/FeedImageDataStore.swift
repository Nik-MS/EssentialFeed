//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 4/17/24.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>

    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
