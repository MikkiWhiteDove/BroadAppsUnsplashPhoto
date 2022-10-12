//
//  BroadAppsUnsplashUITestsLaunchTests.swift
//  BroadAppsUnsplashUITests
//
//  Created by Mishana on 10.10.2022.
//

import XCTest

final class BroadAppsUnsplashUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
