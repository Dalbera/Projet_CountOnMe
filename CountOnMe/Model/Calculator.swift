//
//  Operations.swift
//  CountOnMe
//
//  Created by Gabrielle Dalbera on 30/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum Operator: String {
    case addition = "+"
    case substraction = "-"
    case multiplication = "x"
    case division = "÷"
    case none
}

class Calculator {
    // TODO: -
    // Manage the operations
    // Store the result
    
    var minSelection = 3
    
    var leftValue: Int = 0
    var rightValue: Int = 0
    var operation = Operator.none
    
    var text: String = ""
    
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" } // Return the text typed in textView and removing spaces
    }
    
    var expressionIsCorrect: Bool {
        return elements.first != "+" && elements.first != "-" && elements.first != "x" && elements.first != "÷" // Check that mathematical symbols + and - can be added, if there is already "+" or "-" at the end it will return false
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" // Check that mathematical symbols + and - can be added, if there is already "+" or "-" at the end it will return false
    }
    
    var expressionHasEnoughElements: Bool {
        return elements.count >= minSelection // Check that at least 3 elements have been added to elements (because we need to use at least 2 numbers in operation and a mathematical symbol was used in between
    }
    
    var expressionHasResult: Bool {
        return text.firstIndex(of: "=") != nil // Check that the first elements typed in textView is not =
    }
    
    func transformNegativeIndexes(_ index: Int) {
        var operationsToReduce = elements
        if operationsToReduce[index] == "-" {
            let newNumber = operationsToReduce[index] + operationsToReduce[index + 1]
            operationsToReduce[index] = newNumber
            operationsToReduce.remove(at: index + 1) // After the fusion we remove the element at the index + 1.
        }
    }
    
    
    func reset() {
        text = ""
    }
    
   
//
//    func clearCalculator() {
//
//    }
    
    func calculate(_ operand: Operator) -> Int{
        let result: Int
        switch operand {
        case .addition: result = leftValue + rightValue
        case .substraction: result = leftValue - rightValue
        case .multiplication: result = leftValue * rightValue
        case .division:
            if (leftValue > 0 && rightValue > 0) {
                return  leftValue / rightValue
            } else {
                return 0
            }
        case .none:
            return 0
        }
        return result
    }
    
}
