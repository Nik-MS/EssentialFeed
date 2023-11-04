//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 11/4/23.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
