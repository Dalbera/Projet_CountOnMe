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
        guard let numberText = sender.title(for: .normal) else { // Get the title of the button selected and save it to numberText
            return
        }
        if textView.text.first == "=" {
            resetCalculator()
        }
        addToCalculator(numberText)
    }
    
    @IBAction private func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }
        if textView.text.first == "=" {
            resetCalculator()
        }
        if textView.text ==  "" || !calculator.canAddOperator { // If user starts calculation with an operator, then return error
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
        
        let result = calculator.calculate()
        textView.text = ""
        textView.text.append("= \(result)") // add in textView the result of the operation (reading index 0 of operationsToReduce)
        
    }
    
    // MARK: - Methods
    
    private func resetCalculator() {
        calculator.reset()
        textView.text = ""
    }
    
    private func addToCalculator(_ element: String) {
        textView.text.append(element) // Communicate element to the View
        calculator.appendText(element) // Communicate element to Model
    }
    
}

