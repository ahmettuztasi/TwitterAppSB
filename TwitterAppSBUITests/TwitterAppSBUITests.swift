//
//  TwitterAppSBUITests.swift
//  TwitterAppSBUITests
//
//  Created by KO on 17/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import XCTest

class TwitterAppSBUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()

        app.launchArguments.append("--uitesting")
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testGoingThroughOnboarding() {
        app.launch()
        
        // Make sure we're displaying onboarding
        //XCTAssertTrue(true)
        app.swipeUp()
        let profileImg = XCUIApplication().images["profileImg"].firstMatch
        profileImg.tap()
        
        app.buttons["editUser"].tap()
        
        let firstNameTF = XCUIApplication().textFields["firstName"]
        let lastNameTF = XCUIApplication().textFields["lastName"]
        let userNameTF = XCUIApplication().textFields["userName"]
        let ageTF = XCUIApplication().textFields["age"]
        
        firstNameTF.tap()
        firstNameTF.typeText("Huseyin")
        lastNameTF.tap()
        lastNameTF.typeText("Bagana")
        userNameTF.tap()
        userNameTF.typeText("huseyinbagana")
        ageTF.tap()
        ageTF.typeText("36")
        
        app.buttons["save"].tap()
        profileImg.tap()
        app.swipeUp()
        
        // Onboarding should no longer be displayed
        //XCTAssertFalse(true)
    }
}
