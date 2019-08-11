//
//  QuestionnaireTests.swift
//  QuestionnaireTests
//
//  Created by Raul Brito on 08/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import XCTest
@testable import Questionnaire

class QuestionnaireTests: XCTestCase {

	var viewModelUnderTest: QuestionnaireViewModel!

    override func setUp() {
    	super.setUp()
		
    	viewModelUnderTest = QuestionnaireViewModel(QuestionnaireService())
    }

    override func tearDown() {
    	viewModelUnderTest = nil
		
    	super.tearDown()
    }

    func testFailedResult() {
		let result = 6
		
		viewModelUnderTest.evaluate(result: result)
		
		XCTAssertLessThanOrEqual(viewModelUnderTest.result, 6, "Result not failing")
		XCTAssertEqual(viewModelUnderTest.message, "Unfortunately, we don’t match!", "Wrong fail message")
    }
	
    func testOKResult() {
    	let result = 9
		
		viewModelUnderTest.evaluate(result: result)
		
		XCTAssertGreaterThanOrEqual(viewModelUnderTest.result, 7, "Result less than expected")
		XCTAssertLessThanOrEqual(viewModelUnderTest.result, 9, "Result greater than expected")
		XCTAssertEqual(viewModelUnderTest.message, "That looks good!", "Wrong OK message")
    }
	
    func testExcelentResult() {
    	let result = 10
		
		viewModelUnderTest.evaluate(result: result)
		
		XCTAssertGreaterThanOrEqual(viewModelUnderTest.result, 10, "Result less than expected")
		XCTAssertEqual(viewModelUnderTest.message, "Excellent!", "Wrong Excelent message")
    }

    func testComputingResultsPerformance() {
        self.measure {
        	viewModelUnderTest.evaluate(result: 5)
        }
    }

}
