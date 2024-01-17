//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 9/2/23.
//

import Foundation


public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
