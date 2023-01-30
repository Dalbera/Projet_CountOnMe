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
    case division = "/"
}

class Calculator {
    // TODO: -
    // Manage the operations
    // Store the result
    
    var minSelection = 3

    private var result: Int = 0
    
    func calculate(_ leftValue: Int, _ operation: Operator, _ rightValue: Int) -> Int{
        let result: Int
        switch operation {
        case .addition: result = leftValue + rightValue
        case .substraction: result = leftValue - rightValue
        case .multiplication: result = leftValue * rightValue
        case .division: result = leftValue / rightValue // TODO: - Add conditions, values should not be 0
        }
        return result
    }
}
