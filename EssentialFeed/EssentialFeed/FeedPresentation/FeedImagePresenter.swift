//
//  FeedImagePresenter.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 2/6/24.
//

import Foundation

final public class FeedImagePresenter {
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location)
    }
}
