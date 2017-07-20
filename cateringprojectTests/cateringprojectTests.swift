//
//  cateringprojectTests.swift
//  cateringprojectTests
//
//  Created by Amith Kumar Aellanki and Jadhav Amarnath on 6/10/16.
//  Copyright © 2016 Amith Kumar Aellanki. All rights reserved.
//
// Author: Amit Kumar Aellanki and Jadhav Amarnath

import XCTest
@testable import cateringproject

class cateringprojectTests: XCTestCase {
    var nameString:String?
    var passString :String?
    //alert
    var sut: signupAdminViewController!

    
    
    
    override func setUp() {
        super.setUp()
        nameString="john"
        passString="123456"
        //alert
        
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! signupAdminViewController
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = sut
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
   
    
    func testAlert_HasTitle() {

        XCTAssertTrue(sut.presentedViewController is UIAlertController)
        XCTAssertEqual(sut.presentedViewController?.title, "Test Title")
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertEqual(nameString, "john")
       // XCTAssertEqualWithAccuracy([[store selectedDate] timeIntervalSinceReferenceDate], [date timeIntervalSinceReferenceDate], 0.001);

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDateFormatterPerformance() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let date = NSDate()
        
        measureBlock() {
            let string = dateFormatter.stringFromDate(date)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
