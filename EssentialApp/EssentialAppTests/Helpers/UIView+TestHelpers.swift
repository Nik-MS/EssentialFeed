//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Nikhil Menon on 6/19/24.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: .now)
    }
}
