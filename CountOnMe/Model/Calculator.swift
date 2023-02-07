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
    
    enum Operator: String {
        case addition = "+"
        case substraction = "-"
        case multiplication = "x"
        case division = "÷"
    }
    
    // MARK: - Properties
    
    private var minSelection = 3
    
    private(set) var text: String = ""
    
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" } // Return the text typed in textView and removing spaces
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" // Check if the last entry is anything other than an operator
    }
    
    var expressionHasEnoughElements: Bool {
        return elements.count >= minSelection // Check that at least 3 elements have been added to elements (because we need to use at least 2 numbers in operation and a mathematical symbol was used in between
    }
    
    var isEmpty: Bool {
        return text == ""
    }
    
    var expressionHasResult: Bool {
        return text.first == "="
    }
    
    // MARK: - Methods
    
    func reset() {
        text = ""
    }
    
    func appendText(_ message: String) {
        text.append(message)
    }
    
    func calculate() -> String {
        // Create local copy of the operation
        var operationsToReduce = elements
        
        // Prioritize the multiplication and division
        var operationIsCorrect = true
        operationsToReduce.forEach {
            if $0 == "÷" || $0 == "x" {
                var operatorIndex = operationsToReduce.firstIndex(of: $0)!
                let leftValue = Double(operationsToReduce[operatorIndex - 1])!
                let operand = Operator(rawValue: operationsToReduce[operatorIndex])
                let rightValue = Double(operationsToReduce[operatorIndex + 1])!
                
                let result: Double
                
                switch operand {
                case .multiplication: result = leftValue * rightValue
                case .division:
                    if (leftValue > 0 && rightValue > 0) {
                        result = leftValue / rightValue
                    } else {
                        operationIsCorrect = false // If division using 0, we stop here
                        return
                    }
                default: fatalError("Unknown operator !")
                }

                // Once multiplication or division is done, we remove the operator and left/right values from the array...
                operationsToReduce.removeSubrange(operatorIndex - 1...operatorIndex + 1)
                operatorIndex -= 1
                // ... And insert the result of the operation at the index of previously used indexes
                operationsToReduce.insert(String(result), at: operatorIndex)
            }
        }
        
        if operationIsCorrect == false { // If division using 0, we get directly here and return error
            let error = "Erreur"
            return error
        }
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let leftValue = Double(operationsToReduce[0])!
            let operand = Operator(rawValue: operationsToReduce[1])
            let rightValue = Double(operationsToReduce[2])!
            
            
            let result: Double
            switch operand {
            case .addition: result = leftValue + rightValue
            case .substraction: result = leftValue - rightValue
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
    
        }
        
        let total = operationsToReduce[0]
        return total
        
    }
}
