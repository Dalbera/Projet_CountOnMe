//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    
    var calculator: Calculator!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        calculator = Calculator()
    
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testGivenNumber_WhenAdditionningWithAnotherNumber_ThenPrintingResult() {
        calculator.appendText("1 + 5")
        let result = calculator.calculate()
        
        XCTAssert(result == 6)
    }
    
    func testGivenNumber_WhenSubstractingWithAnotherNumber_ThenPrintingResult() {
        calculator.appendText("9 - 4")
        let result = calculator.calculate()
        
        XCTAssert(result == 5)
    }
    
    func testGivenNumber_WhenMultiplicatingByAnotherNumber_ThenPrintingResult() {
//        calculator.appendText("6 x 6")
//        let result = calculator.calculate()
//
//        XCTAssert(result == 36)
    }
    
    func testGivenNumber_WhenDivisingByAnotherNumber_ThenPrintingResult() {
//        calculator.appendText("40 ÷ 10")
//        let result = calculator.calculate()
//
//        XCTAssert(result == 4)
    }
        
    func testGivenNumber_WhenDivisingByZero_ThenReturningError() {

    }
    
    func testGivenClearViewButton_WhenTapped_ThenClearTextView() {
        
    }
    
    func testGivenNewCalculation_WhenAddingFirstAMultiplie_ThenReturningError() {
        
    }
    
    func testGivenNewCalculation_WhenAddingFirstEqual_ThenReturningError() {
        
    }
    
    func testGivenOperatorIsAdded_WhenAddingAMinusOperator_ThenProcedingWithCalculation() {
        
    }
    
    func testGivenOperatorIsAdded_WhenAddingAPlusOperator_ThenReturningError() {
        
    }
    
    func testGivenNewCalculation_WhenAddingHugeNumbers_ThenPrintingResult() {
        
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
