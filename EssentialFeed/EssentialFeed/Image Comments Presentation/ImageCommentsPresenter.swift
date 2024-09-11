//
//  ImageCommentsPresenter.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 8/17/24.
//

import Foundation

public struct ImageCommentsViewModel: Equatable, Hashable {
    public let comments: [ImageCommentViewModel]
}

public struct ImageCommentViewModel: Equatable, Hashable {
    public init(message: String, date: String, username: String) {
        self.message = message
        self.date = date
        self.username = username
    }
    
    public let message: String
    public let date: String
    public let username: String
}

public final class ImageCommentsPresenter {
    public static var title: String {
        NSLocalizedString("IMAGE_COMMENTS_VIEW_TITLE", tableName: "ImageComments", bundle: Bundle(for: ImageCommentsPresenter.self), comment: "Title for the feed view")
    }
    
    public static func map(_ comments: [ImageComment], currentDate: Date = .now, calendar: Calendar = .current, locale: Locale = .current) -> ImageCommentsViewModel {
        let formatter = RelativeDateTimeFormatter()
        formatter.calendar = calendar
        formatter.locale = locale
        
        return ImageCommentsViewModel(comments: comments.map { comment in
            let relativeDate = formatter.localizedString(for: comment.createdAt, relativeTo: currentDate)
            return ImageCommentViewModel(message: comment.message, date: relativeDate, username: comment.username)
        })
    }
}
