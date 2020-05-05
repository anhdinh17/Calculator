//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Anh Dinh on 5/2/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import UIKit

struct CalculatorLogic {
    
    // we make this number optional because think about it, when we don't press any numbers yet, this variable should be nil until we press any number-buttons.
    // Or more logically, this runs before viewDidLoad() runs, that's why it has no value at the beginning until users press buttons.
    private var number: Double?
    
    // create a tuple to store the first number and the operator
    // we make this var optional for the same reason above.
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    // because we set number is private, we create this function so that we can update/modify value of number from other class. In this case, we need to set number = displayValue from ViewController.
    mutating func setNumber(_ number: Double){
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double?{
        
        if let n = number{
            switch symbol {
            case "+/-":
                return n * -1
            case "AC":
                return 0
            case "%":
                return n * 0.01
            case "=":
                return performTwoNumCalculation(n2: n)
            default:
                intermediateCalculation = (n1: n, calcMethod: symbol)
            }
        }
        
        return nil // need a return here because there's still chance that symbol is not of those options
        // if we want to return nil then the return type has to be Optional
    }
    
    private func performTwoNumCalculation(n2: Double) -> Double?{
        // optional binding because intermediateCalculation is optional
        if let n1 = intermediateCalculation?.n1,
            let operation = intermediateCalculation?.calcMethod {
            switch operation{
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("Error: Operator doesn't match any of listed ones.")
            }
        }
        return nil
    }
    
}

/*
 
 */
