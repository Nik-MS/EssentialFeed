//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 2/20/24.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
