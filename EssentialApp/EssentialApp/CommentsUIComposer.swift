//
//  CommentsUIComposer.swift
//  EssentialApp
//
//  Created by Nikhil Menon on 9/11/24.
//

import UIKit
import EssentialFeed
import EssentialFeediOS
import Combine

public final class CommentsUIComposer {
    private init() { }
    
    private typealias CommentPresentationAdapter = LoadResourcePresentationAdapter<[ImageComment], CommentsViewAdapter>
    
    public static func commentsComposedWith(
        commentsLoader: @escaping () -> AnyPublisher<[ImageComment], Swift.Error>) -> ListViewController {
        let presentationAdapter = CommentPresentationAdapter(loader: commentsLoader)
        let commentsController = makeCommentsViewController(title: ImageCommentsPresenter.title)
        commentsController.onRefresh = presentationAdapter.loadResource
        
        let weakCommentsController = WeakRefVirtualProxy(commentsController)
        let presenter = LoadResourcePresenter(
            resourceView: CommentsViewAdapter(controller: commentsController),
            loadingView:  WeakRefVirtualProxy(commentsController),
            errorView: weakCommentsController,
            mapper: { ImageCommentsPresenter.map($0) }
        )
        
        presentationAdapter.presenter = presenter
        
        return commentsController
    }
    
    private static func makeCommentsViewController(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "ImageComments", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! ListViewController
        controller.title = title
        return controller
    }
}

final class CommentsViewAdapter: ResourceView {
    private weak var controller: ListViewController?
    
    init(controller: ListViewController?) {
        self.controller = controller
    }
    
    func display(_ viewModel: ImageCommentsViewModel) {
        controller?.display(viewModel.comments.map { viewModel in
            CellController(id: viewModel, ImageCommentCellController(model: viewModel))
        })
    }
}

