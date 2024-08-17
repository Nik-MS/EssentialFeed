//
//  ImageCommentsPresenter.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 8/17/24.
//

import Foundation

public final class ImageCommentsPresenter {
    public static var title: String {
        NSLocalizedString("IMAGE_COMMENTS_VIEW_TITLE", tableName: "ImageComments", bundle: Bundle(for: ImageCommentsPresenter.self), comment: "Title for the feed view")
    }
    
    public static func map(_ feed: [FeedImage]) -> FeedViewModel {
        FeedViewModel(feed: feed)
    }
}
