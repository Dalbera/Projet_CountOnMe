//
//  Operations.swift
//  CountOnMe
//
//  Created by Gabrielle Dalbera on 30/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
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
    
    var operationIsCorrect = true
    
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
        operationIsCorrect = true
        // If there are operator x or /, calculate these operations first and store the result.
        var operationConverted = calculateResultOfMultiplicationOrDivision(operationsToReduce)
        
        if operationIsCorrect == false { // If division using 0, we get directly here and return error
            let error = "Erreur"
            return error
        }
        
        // Iterate over operations while an operand still here
        while operationConverted.count > 1 {
            let leftValue = Double(operationConverted[0])!
            let operand = Operator(rawValue: operationConverted[1])
            let rightValue = Double(operationConverted[2])!
            
            
            let result: Double
            switch operand {
            case .addition: result = leftValue + rightValue
            case .substraction: result = leftValue - rightValue
            default: fatalError("Unknown operator !")
            }
            
            operationConverted = Array(operationConverted.dropFirst(3))
            operationConverted.insert("\(result)", at: 0)
            
        }
        
        let total = operationConverted[0]
        return total
        
    }
    
    func calculateResultOfMultiplicationOrDivision(_ elements: [String]) -> [String] {
        var elements = elements
        elements.forEach {
            if $0 == "÷" || $0 == "x" {
                var operatorIndex = elements.firstIndex(of: $0)!
                let leftValue = Double(elements[operatorIndex - 1])!
                let operand = Operator(rawValue: elements[operatorIndex])
                let rightValue = Double(elements[operatorIndex + 1])!
                
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
                elements.removeSubrange(operatorIndex - 1...operatorIndex + 1)
                operatorIndex -= 1
                // ... And insert the result of the operation at the index of previously used indexes
                elements.insert(String(result), at: operatorIndex)
            }
        }
        return elements
    }
    
}
