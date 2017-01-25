//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Ali Siddiqui on 1/25/17.
//  Copyright © 2017 Ali Siddiqui. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet fileprivate weak var display: UILabel!
    
    private var brain = CalculatorModel()
    
    private var inMiddleOfTyping = false
    
    private var numInDisplay: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        
        if inMiddleOfTyping {
            display.text! += sender.currentTitle!
            inMiddleOfTyping = true
        } else if inMiddleOfTyping == false && sender.currentTitle! != "0" {
            display.text = sender.currentTitle!
            inMiddleOfTyping = true
        }
        
    }
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        
        inMiddleOfTyping = false
        
        brain.setOperand(Double(display.text!)!)
        
        brain.doOperation(sender.currentTitle!)
        
        numInDisplay = brain.result
        
        
    }
    
    fileprivate var savedProgram: AnyObject?
    
    @IBAction func setProgram(_ sender: AnyObject) {
        savedProgram = brain.program
    }
    
    @IBAction func runProgram(_ sender: AnyObject) {
        if let program = savedProgram {
            brain.program = program
            numInDisplay = brain.result
        }
    }
}

