//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 2/12/24.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
