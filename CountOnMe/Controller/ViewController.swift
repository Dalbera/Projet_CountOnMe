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
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    @IBOutlet var operatorButtons: [UIButton]!
    
    @IBOutlet weak var resetButton: UIButton!
    
    func resetCalculator() {
        textView.text = ""
    }
    
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" } // Return the text typed in textView and removing spaces
    }
    
    // MARK: - Properties
    // Error check computed variables
    
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" // Check that the elements selected before = are numbers and not + or -
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3 // Check that at least 3 elements have been added to elements (because we need to use at least 2 numbers in operation and a mathematical symbol was used in between
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" // Check that mathematical symbols + and - can be added, if there is already "+" or "-" at the end it will return false
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil // Check that the first elements typed in textView is not =
    }
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        resetCalculator()
    }
    
    
    // MARK: - View Actions
    
    @IBAction func tappedResetButton(_ sender: UIButton) {
        resetCalculator()
    }
    
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { // Get the title of the button selected and save it to numberText
            return
        }
        if expressionHaveResult {
            textView.text = "" // If the first element typed in textView is "=", nothing is displayed in textView
        }
        textView.text.append(numberText) // If all conditions above allows it, add numberText to the text in textView and elements
    }
    
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            resetCalculator()
        }
        if canAddOperator {
            textView.text.append(" \(operatorText) ")
        } else {
            resetCalculator()
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            
        }
    }
    

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else { // allows typing "=" button only if it is not the first element typed in textView
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else { // adds another condition to type "=" button : there should be at least 2 numbers and a mathematical symbol in between
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // Create local copy of operations
        var operationsToReduce = elements // preparing a var to store the result of the operations (need to take the indexes of elements for that)
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 { // The strategy here is to keep only one data in operationsToReduce, which will be the result so there is a while loop to continue as long as there is more than 1 index.
            let left = Float(operationsToReduce[0])! // Index 0 is stored in "left" constant
            let operand = operationsToReduce[1] // Index 1 is stored as "operand" constant
            let right = Float(operationsToReduce[2])! // Index 2 is stored in "right" constant
            // If there are more indexes, the first 3 will be calculated, the result takes the first place and the 2 following indexes will be removed and it continues until there is only 1 index in the array.
            
            let result: Float
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            default: fatalError("Unknown operator !") // only "+" and "-" are allowed
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3)) // Remove first 3 index of operationsToReduce
            operationsToReduce.insert("\(result)", at: 0) // add the result of the operation to var operationsToReduce at index 0
        }
        
        textView.text.append(" = \(operationsToReduce.first!)") // add in textView the result of the operation (reading index 0 of operationsToReduce)
    }

}

