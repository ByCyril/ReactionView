//
//  ReactionViewTests.swift
//  ReactionViewTests
//
//  Created by Cyril Garcia on 7/11/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import XCTest
@testable import ReactionView

class ReactionViewTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testtrigTest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let vc = ViewController()
        let x = vc.getX(60, 50)
        let y = vc.getY(60, x)
        
        XCTAssertEqual(x, 25)
        XCTAssertEqual(y, 21.5)
        
        
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
