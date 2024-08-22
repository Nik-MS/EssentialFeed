//
//  ImageCommentCellController.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 8/22/24.
//

import UIKit
import EssentialFeed

public class ImageCommentCellController: CellController {
    private let model: ImageCommentViewModel
    
    public init(model: ImageCommentViewModel) {
        self.model = model
    }
    
    public func view(in tableView: UITableView) -> UITableViewCell {
        return UITableViewCell()
    }
    
    public func preload() { }
    
    public func cancelLoad() { }
}
