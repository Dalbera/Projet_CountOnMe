//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

// TODO: When user taps "=", we need to get the result from Calculator and display it to the textView


class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    @IBOutlet private var operatorButtons: [UIButton]!
    @IBOutlet private weak var resetButton: UIButton!
    
    // MARK: - Properties
    
    private var calculator = Calculator()
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.reset()
    }
    
    // MARK: - View Actions
    
    @IBAction private func tappedResetButton(_ sender: UIButton) {
        calculator.reset()
        textView.text = ""
    }
    
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { // Get the title of the button selected and save it to numberText
            return
        }
        if calculator.expressionHasResult {
            calculator.reset()
            textView.text = ""
        }
        textView.text.append(numberText) // If all conditions above allows it, add numberText to the text in textView
        calculator.text.append(numberText) // when textView.text is updated, we need to send the text value to the text property in Calculator to be able to compute
    }
    
    @IBAction private func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }
        if calculator.expressionHasResult {
            calculator.reset()
            textView.text = ""
        }
        if calculator.expressionIsCorrect {
            textView.text.append(" \(operatorText) ")
            calculator.text.append(" \(operatorText) ")
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
            textView.text = ""
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
        
        let result = calculator.calculate()
        textView.text = ""
        textView.text.append(" = \(result)") // add in textView the result of the operation (reading index 0 of operationsToReduce)
    }
    
    // MARK: - Methods

    

}

