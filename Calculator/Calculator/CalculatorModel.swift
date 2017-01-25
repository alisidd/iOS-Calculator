//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Ali Siddiqui on 1/25/17.
//  Copyright © 2017 Ali Siddiqui. All rights reserved.
//

import Foundation

class CalculatorModel {
    
    fileprivate var accumulator: Double = 0
    fileprivate var internalProgram = [AnyObject]()
    
    class pendingOp {
        var function: ((Double, Double) -> Double)?
    }
    
    var pending = pendingOp()
    
    func setOperand(_ value: Double) {
        internalProgram.append(value as AnyObject)
        if pending.function != nil {
            accumulator = pending.function!(accumulator, value)
        } else {
            accumulator = value
        }
    }
    
    func doOperation(_ operation: String) {
        internalProgram.append(operation as AnyObject)
        switch operation {
        case "+":
            pending.function = {$0 + $1}
        case "-":
            pending.function = {$0 - $1}
        case "×":
            pending.function = {$0 * $1}
        case "÷":
            pending.function = {$0 / $1}
        case "√":
            accumulator = sqrt(accumulator)
            fallthrough
        case "=":
            pending.function = nil
        default: break
        }
    }
    
    var program: AnyObject {
        get {
            return internalProgram as AnyObject
        }
        set {
            if let unknownObject = newValue as? [AnyObject] {
                for object in unknownObject {
                    if let value = object as? Double {
                        setOperand(value)
                    } else if let operation = object as? String {
                        doOperation(operation)
                    }
                }
            }
            
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
