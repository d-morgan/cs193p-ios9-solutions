//
//  ViewController.swift
//  Calculator
//
//  Created by Kanstantsin Linou on 7/13/16.
//  Copyright © 2016 Kanstantsin Linou. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet fileprivate weak var display: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    fileprivate var userIsInTheMiddleOfTyping = false
    
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            if digit != "." || textCurrentlyInDisplay.range(of: ".") == nil {
                display.text = textCurrentlyInDisplay + digit
            }
        } else {
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        brain.clear()
        displayValue = 0
        userIsInTheMiddleOfTyping = false
    }
    
    @IBAction func backspace(_ sender: UIButton) {
        guard userIsInTheMiddleOfTyping == true else {
            return
        }
        
        guard var number = display.text else {
            return
        }
        
        number.remove(at: number.characters.index(before: number.endIndex))
        if number.isEmpty {
            number = "0"
            userIsInTheMiddleOfTyping = false
        }
        display.text = number
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
            descriptionLabel.text = brain.getDescription()
        }
    }

    fileprivate var brain = CalculatorBrain()
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        displayValue = brain.result
    }
}
