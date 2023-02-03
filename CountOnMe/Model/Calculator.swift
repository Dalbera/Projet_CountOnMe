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
    
    private var leftValue: Int = 0
    private var rightValue: Int = 0
    var operation = Operator.none
    
    enum Operator: String {
        case addition = "+"
        case substraction = "-"
        case multiplication = "x"
        case division = "÷"
        case none
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
    
    private func transformNegativeIndexes(_ index: Int) {
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
    
    func calculationIsOver() {
        operation = .none
    }
    
    func calculate() -> Int {
        var result: Int
        // Create local copy of operations
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 { // The strategy here is to keep only one data in operationsToReduce, which will be the result so there is a while loop to continue as long as there is more than 1 index.
            // If there are more indexes, the first 3 will be calculated, the result takes the first place and the 2 following indexes will be removed and it continues until there is only 1 index in the array.
            transformNegativeIndexes(0)
            leftValue = Int(operationsToReduce[0])! // Index 0 is stored in "leftValue" constant
            transformNegativeIndexes(2)
            rightValue = Int(operationsToReduce[2])! // Index 2 is stored in "rightValue" constant
            
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
            case .none:
                return 0
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3)) // Remove first 3 index of operationsToReduce
            operationsToReduce.insert("\(result)", at: 0) // add the result of the operation to var operationsToReduce at index 0
            return result
        }
        return 0
    }
    
    
    
}
