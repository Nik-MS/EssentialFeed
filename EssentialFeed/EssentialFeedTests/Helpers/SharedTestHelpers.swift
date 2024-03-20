//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Nikhil Menon on 12/12/23.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 1)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data { Data("any data".utf8) }
