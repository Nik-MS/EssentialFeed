//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by Nikhil Menon on 6/5/24.
//

import Foundation
import EssentialFeed

func anyURL() -> URL { URL(string: "http://a-url.com")! }

func anyNSError() -> NSError { NSError(domain: "any error", code: 0) }

func anyData() -> Data { Data("any data".utf8) }

func uniqueFeed() -> [FeedImage] {
    [FeedImage(id: .init(), description: "any", location: "any", url: anyURL())]
}
