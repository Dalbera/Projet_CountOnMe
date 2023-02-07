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
    @IBOutlet private var numberButtons: [UIButton]! // Collection of all numbers buttons
    @IBOutlet private var operatorButtons: [UIButton]! // Collection of all operators buttons
    @IBOutlet private weak var resetButton: UIButton!
    
    // MARK: - Properties
    
    private let calculator = Calculator()
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetCalculator()
    }
    
    // MARK: - View Actions
    
    @IBAction private func tappedResetButton(_ sender: UIButton) {
        resetCalculator()
    }
    
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { // This Action is linked to ALL number buttons, we fetch the title of the number button selected and save it to numberText
            return
        }
        if calculator.expressionHasResult { // If there is still the result of a previous operation, clear the calculator to start a new operation
            resetCalculator()
        }
        addToCalculator(numberText)
    }
    
    @IBAction private func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else { // This Action is linked to the operator (+, -, x and /) buttons, we fetch the title of the button selected and save it to operatorText
            return
        }
        if calculator.expressionHasResult { // If there is still the result of a previous operation, clear the calculator to start a new operation
            resetCalculator()
        }
        if calculator.isEmpty || !calculator.canAddOperator { // If user starts calculation with an operator or if there is already an operator, then return error
            resetCalculator()
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrée invalide ! Démarrez un nouveau calcul.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        } else {
            addToCalculator(" \(operatorText) ")
        }
    }
    
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        
        guard calculator.expressionHasEnoughElements else { // adds another condition to type "=" button : there should be at least 2 numbers and a mathematical symbol in between
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        displayResult()
    }
    
    // MARK: - Methods
    
    private func resetCalculator() {
        calculator.reset() // Clear the data of the operation saved in the Model
        textView.text = "" // Clear the data of the operation in the View
    }
    
    private func addToCalculator(_ element: String) {
        textView.text.append(element) // Communicate element to the View
        calculator.appendText(element) // Communicate element to Model
    }
    
    private func displayResult() {
        let result = calculator.calculate() // Start operation and save the result
        resetCalculator()
        addToCalculator("= \(result)")
    }
    
}

