//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    @IBOutlet private var operatorButtons: [UIButton]!
    @IBOutlet private weak var resetButton: UIButton!
    
    // MARK: - Properties
    
    private var calculator = Calculator()
    
    // TODO: when textView.text is updated, send the text value to the text property in Calculator
    
    // UITextViewDelegate -> textViewDidChange
    
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.reset()
    }
    
    // MARK: - View Actions
    
    @IBAction private func tappedResetButton(_ sender: UIButton) {
        calculator.reset()
    }
    
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { // Get the title of the button selected and save it to numberText
            return
        }
        if calculator.expressionHasResult {
            textView.text = "" // If the first element typed in textView is "=", nothing is displayed in textView
        }
        textView.text.append(numberText) // If all conditions above allows it, add numberText to the text in textView and elements
    }
    
    @IBAction private func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }
        if calculator.expressionHasResult {
            calculator.reset()
        }
        if calculator.expressionIsCorrect {
            textView.text.append(" \(operatorText) ")
            //            if operatorText == "+" {
            //                calculator.operation = Operator.addition
            //            } else if operatorText == "-" {
            //                calculator.operation = Operator.substraction
            //            } else if operatorText == "*" {
            //                calculator.operation = Operator.multiplication
            //            } else if operatorText == "÷" {
            //                calculator.operation = Operator.division
            //            }
            
            
        } else {
            calculator.reset()
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrée invalide !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else { // allows typing "=" button only if it is not the first element typed in textView
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calculator.expressionHasEnoughElements else { // adds another condition to type "=" button : there should be at least 2 numbers and a mathematical symbol in between
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        // ÷
        
        // Create local copy of operations
        var operationsToReduce = calculator.elements // preparing a var to store the result of the operations (need to take the indexes of elements for that)
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 { // The strategy here is to keep only one data in operationsToReduce, which will be the result so there is a while loop to continue as long as there is more than 1 index.
            // If there are more indexes, the first 3 will be calculated, the result takes the first place and the 2 following indexes will be removed and it continues until there is only 1 index in the array.
            
            
            calculator.transformNegativeIndexes(0)
            calculator.leftValue = Int(operationsToReduce[0])! // Index 0 is stored in "leftValue" constant
            calculator.transformNegativeIndexes(2)

            if operationsToReduce[2] == "+" || operationsToReduce[2] == "-" {
                let newNumber = operationsToReduce[2] + operationsToReduce[3]
                operationsToReduce[2] = newNumber
                operationsToReduce.remove(at: 3) // After the fusion we remove the element at the index 1.
            }
            calculator.rightValue = Int(operationsToReduce[2])! // Index 2 is stored in "rightValue" constant
            
            guard let operand = Operator(rawValue: operationsToReduce[1]) else {
                calculator.reset()
                let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                return self.present(alertVC, animated: true, completion: nil)
            }
            let result = calculator.calculate(operand)
            operationsToReduce = Array(operationsToReduce.dropFirst(3)) // Remove first 3 index of operationsToReduce
            operationsToReduce.insert("\(result)", at: 0) // add the result of the operation to var operationsToReduce at index 0
        }
        
        textView.text.append(" = \(operationsToReduce.first!)") // add in textView the result of the operation (reading index 0 of operationsToReduce)
        
    }
    
    // MARK: - Methods

    

}

