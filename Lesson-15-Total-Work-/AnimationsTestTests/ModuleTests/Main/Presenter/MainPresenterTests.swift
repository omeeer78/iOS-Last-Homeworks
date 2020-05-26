//
//  MainMainPresenterTests.swift
//  Lesson-15-Total-Work-
//
//  Created by omeeer78 on 05/05/2020.
//  Copyright © 2020 ITIS. All rights reserved.
//

import XCTest

class MainPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: MainInteractorInput {

    }

    class MockRouter: MainRouterInput {

    }

    class MockViewController: MainViewInput {

        func setupInitialState() {

        }
    }
}
