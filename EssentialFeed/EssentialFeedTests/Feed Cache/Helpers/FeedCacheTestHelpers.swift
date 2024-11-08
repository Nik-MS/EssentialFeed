//
//  FeedCacheTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Nikhil Menon on 12/12/23.
//

import Foundation
import EssentialFeed

func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
    let models = [uniqueImage(), uniqueImage()]
    let local = models.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    
    return (models, local)
}

func uniqueImage() -> FeedImage {
    return FeedImage(id: UUID(), description: nil, location: nil, url: anyURL())
}

extension Date {
    private var feedCacheMaxAgeInDays: Int {
        return 7
    }
    func minusFeedCacheMaxAge() -> Date {
        return adding(days: -feedCacheMaxAgeInDays)
    }
}
