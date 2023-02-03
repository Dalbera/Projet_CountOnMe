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
    
    func reset() {
        text = ""
    }

//
//    func calculate() -> Int {
//        var result: Int
//        // Create local copy of operations
//        var operationsToReduce = elements
//        // Iterate over operations while an operand still here
//
//        while operationsToReduce.count > 1 {
//
//            let leftValue = Int(operationsToReduce[0])!
//            let rightValue = Int(operationsToReduce[2])!
//
//            guard let operand = Operator(rawValue: operationsToReduce[1]) else {
//                reset() // TODO: Send error to Controller???
//                return 0
//            }
//
//            switch operand {
//            case .addition: result = leftValue + rightValue
//            case .substraction: result = leftValue - rightValue
//            case .multiplication: result = leftValue * rightValue
//            case .division:
//                if (leftValue > 0 && rightValue > 0) {
//                    result = leftValue / rightValue
//                } else {
//                    result = 0
//                }
//            }
//            operationsToReduce = Array(operationsToReduce.dropFirst(3)) // Remove first 3 index of operationsToReduce
//            operationsToReduce.insert("\(result)", at: 0) // add the result of the operation to var operationsToReduce at index 0
//            return result
//        }
//        return 0
//    }
//
    
    
    func calculate() -> Int {
        // Create local copy of operations
        var operationsToReduce = elements
        // Priority given to multiplication and division
        operationsToReduce.forEach {
            if $0 == "÷" || $0 == "x" {
                var operatorIndex = operationsToReduce.firstIndex(of: $0)!
                let leftValue = Int(operationsToReduce[operatorIndex - 1])!
                let operand = Operator(rawValue: operationsToReduce[operatorIndex])
                let rightValue = Int(operationsToReduce[operatorIndex - 1])!
                
                let result: Int
                
                switch operand {
                case .multiplication: result = leftValue * rightValue
                case .division:
                    if (leftValue > 0 && rightValue > 0) {
                        result = leftValue / rightValue
                    } else {
                        result = 0
                    }
                default: fatalError("Unknown operator !")
                }
                
                // Once multiplication or division are done, we remove the operator and left/right values from the array...
                operationsToReduce.removeSubrange(operatorIndex - 1...operatorIndex + 1)
                operatorIndex -= 1
                // ... And insert the result of the operation at the index at the place the whole operation was before
                operationsToReduce.insert(String(result), at: operatorIndex)
            }
        }
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let leftValue = Int(operationsToReduce[0])!
            let operand = Operator(rawValue: operationsToReduce[1])
            let rightValue = Int(operationsToReduce[2])!
            
            
            let result: Int
            switch operand {
            case .addition: result = leftValue + rightValue
            case .substraction: result = leftValue - rightValue
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
    
        }
        
        let total = Int(operationsToReduce[0])!
        return total
        
    }
}
