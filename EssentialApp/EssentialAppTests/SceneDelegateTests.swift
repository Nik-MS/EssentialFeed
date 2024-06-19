//
//  SceneDelegateTests.swift
//  EssentialAppTests
//
//  Created by Nikhil Menon on 6/17/24.
//

import XCTest
import EssentialFeediOS
@testable import EssentialApp

class SceneDelegateTests: XCTestCase {
    
    func test_sceneWillConnectToSession_configuresRootViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindow()
        
        sut.configureWindow()
        
        let root = sut.window?.rootViewController
        let rootNavigation = root as? UINavigationController
        let topController = rootNavigation?.topViewController
        
        XCTAssertNotNil(rootNavigation, "Expected a Nav Controller as root, got \(String(describing: root)) instead.")
        XCTAssertTrue(topController is FeedViewController, "Expected a Feed Controller as top view controller, got \(String(describing: topController)) instead.")
    }
}
