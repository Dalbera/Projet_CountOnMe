//
//  Operations.swift
//  CountOnMe
//
//  Created by Gabrielle Dalbera on 30/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    // TODO: -
    // Manage the operations
    // Store the result
    
    private var minSelection = 3
    
    enum Operator: String {
        case addition = "+"
        case substraction = "-"
        case multiplication = "x"
        case division = "÷"
    }
    
    var text: String = ""
    
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" } // Return the text typed in textView and removing spaces
    }
    
    var expressionIsCorrect: Bool {
        return elements.first != "+" && elements.first != "-" && elements.first != "x" && elements.first != "÷" // Check if the first element is anything different than the 4 operators
    }
    
    var previousElementIsNumber: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" // Check if the last entry is anything other than an operator
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" // Check if the last entry is anything other than an operator
//        return operation == .none
    }
    
    var expressionHasEnoughElements: Bool {
        return elements.count >= minSelection // Check that at least 3 elements have been added to elements (because we need to use at least 2 numbers in operation and a mathematical symbol was used in between
    }
    
    var expressionHasResult: Bool {
        return text.firstIndex(of: "=") != nil // Check that the first elements typed in textView is not =
    }
    
    private func transformNumber(_ operation: [String], _ index: Int) -> Int {
        return Int(operation[index])!
    }
    
    func reset() {
        text = ""
    }
    
    func calculate() -> Int {
        var result: Int
        // Create local copy of operations
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            if operationsToReduce[0] == "-" {
                let newNumber = 0 - Int(operationsToReduce[1])!
                operationsToReduce[0] = String(newNumber)
                operationsToReduce.remove(at: 0)
            }
            let leftValue = transformNumber(operationsToReduce, 0)
            if operationsToReduce[2] == "-" {
                let newNumber = 0 - Int(operationsToReduce[3])!
                operationsToReduce[0] = String(newNumber)
                operationsToReduce.remove(at: 2)
            }
            let rightValue = transformNumber(operationsToReduce, 2)
            
            guard let operand = Operator(rawValue: operationsToReduce[1]) else {
                reset() // TODO: Send error to Controller???
                return 0
            }
            
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
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3)) // Remove first 3 index of operationsToReduce
            operationsToReduce.insert("\(result)", at: 0) // add the result of the operation to var operationsToReduce at index 0
            return result
        }
        return 0
    }
    
    
    
}
