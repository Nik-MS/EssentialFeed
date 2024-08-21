//
//  ListSnapshotTests.swift
//  EssentialFeediOSTests
//
//  Created by Nikhil Menon on 8/21/24.
//

import XCTest
@testable import EssentialFeed
import EssentialFeediOS

final class ListSnapshotTests: XCTestCase {
    func test_emptyFeed() {
        let sut = makeSUT()
        
        sut.display(emptyList())
        
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "EMPTY_LIST_LIGHT")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "EMPTY_LIST_DARK")
    }
    
    func test_listWithErrorMessage() {
        let sut = makeSUT()
        
        sut.display(.error(message: "This is a\nmulti-line\nerror message"))
        
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "LIST_WITH_ERROR_MESSAGE_LIGHT")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "LIST_WITH_ERROR_MESSAGE_DARK")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! ListViewController
        controller.loadViewIfNeeded()
        controller.tableView.showsVerticalScrollIndicator = false
        controller.tableView.showsHorizontalScrollIndicator = false
        controller.refreshControl = nil
        return controller
    }
    
    private func emptyList() -> [CellController] { [] }
}
