//
//  GitHudUserViewController.swift
//  Example CombineUITests
//
//  Created by Rodrigo Amora on 20/01/25.
//

import Foundation
import XCTest

class GitHudUserViewController: XCTestCase {
    
    // MARK: - Atributes
    var app: XCUIApplication!

    // MARK: - setUp
    override func setUp() {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launchArguments = ["testing"]
        self.app.launch()
    }
    
    // MARK: - tearDownWithError
    override func tearDownWithError() throws {}
        
    // MARK: - Test Methods
    func testSearchGitHubUser() throws {
        let gitHubUserName = "RodrigoAmora"
        
        let userNameTextField = self.app.textFields["userNameTextField"]
        userNameTextField.tap()
        userNameTextField.typeText(gitHubUserName)
        
        let sendButton = self.app.buttons["sendButton"]
        sendButton.tap()
        
        let expectation = XCTestExpectation(description: "Your expectation")
        let timeInSeconds = 7.0
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeInSeconds + 1.0)
        
        let userNameLabel = self.app.staticTexts["userNameLabel"]
        
        XCTAssertFalse(userNameLabel.label.isEmpty)
        XCTAssertEqual(gitHubUserName, userNameLabel.label)
    }
    
}
