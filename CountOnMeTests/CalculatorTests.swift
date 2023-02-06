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

    
    func testGivenNumber_WhenAdditionningWithAnotherNumber_ThenResultShouldBeCorrect() {
        //Given
        calculator.appendText("1 + 5")
        //When
        let result = calculator.calculate()
        //Then
        XCTAssert(result == "6.0")
    }
    
    func testGivenNumber_WhenSubstractingWithAnotherNumber_ThenResultShouldBeCorrect() {
        //Given
        calculator.appendText("9 - 4")
        //When
        let result = calculator.calculate()
        //Then
        XCTAssert(result == "5.0")
    }
    
    func testGivenNumber_WhenMultiplicatingByAnotherNumber_ThenResultShouldBeCorrect() {
        //Given
        calculator.appendText("6 x 6")
        //When
        let result = calculator.calculate()
        //Then
        XCTAssert(result == "36.0")
    }
    
    func testGivenNumber_WhenDivisingByAnotherNumber_ThenResultShouldBeCorrect() {
        //Given
        calculator.appendText("40 ÷ 10")
        //When
        let result = calculator.calculate()
        //Then
        XCTAssert(result == "4.0")
    }
        
    func testGivenNumber_WhenDivisingByZero_ThenReturningError() {
        //Given
        calculator.appendText("7 ÷ 0")
        //When
        let result = calculator.calculate()
        //Then
        XCTAssert(result == "Erreur")
    }
    
    func testGivenOperationWithMultipleOperators_WhenCalculating_MultiplicationAndDivisionArePrioritized() {
        //Given
        calculator.appendText("3 + 27 ÷ 3 - 8")
        //When
        let result = calculator.calculate()
        //Then
        XCTAssert(result == "4.0")
    }
    
    func testGivenNewCalculation_WhenAddingAnOperatorFirst_ThenOperatorIsNotAdded() {
        //Given
        calculator.appendText("")
        //When
        let result = calculator.isEmpty
        //Then
        XCTAssert(result)
    }
    
    func testGivenNewCalculation_WhenAddingFirstEqual_ThenEqualIsNotAdded() {
        //Given
        calculator.appendText("")
        //When
        let result = calculator.expressionHasResult
        //Then
        XCTAssertFalse(result)
    }
    
    func testGivenAddition_WhenAddingAnotherOperator_ThenOperatorIsNotAdded() {
        //Given
        calculator.appendText("2 +")
        //When
        let result = calculator.canAddOperator
        //Then
        XCTAssertFalse(result)
    }
    
    func testGivenSubstraction_WhenAddingAnotherOperator_ThenOperatorIsNotAdded() {
        //Given
        calculator.appendText("2 -")
        //When
        let result = calculator.canAddOperator
        //Then
        XCTAssertFalse(result)
    }
    
    func testGivenMultiplication_WhenAddingAnotherOperator_ThenOperatorIsNotAdded() {
        //Given
        calculator.appendText("2 x")
        //When
        let result = calculator.canAddOperator
        //Then
        XCTAssertFalse(result)
    }
    
    func testGivenDivision_WhenAddingAnotherOperator_ThenOperatorIsNotAdded() {
        //Given
        calculator.appendText("2 ÷")
        //When
        let result = calculator.canAddOperator
        //Then
        XCTAssertFalse(result)
    }
    
    func testGivenOperationWith1Element_WhenStartingCalculation_ThenOperationCannotProceed() {
        //Given
        calculator.appendText("145")
        //When
        let result = calculator.expressionHasEnoughElements
        //Then
        XCTAssertFalse(result)
    }
    
    func testGivenNewCalculation_WhenAddingHugeNumbers_ThenResultIsCorrect() {
        //Given
        calculator.appendText("123456789 x 1000000000")
        //When
        let result = calculator.calculate()
        //Then
        XCTAssert(result == "1.23456789e+17")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
