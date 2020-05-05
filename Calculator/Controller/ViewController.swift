//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    //when app first start, this is true
    var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        // use the get{} to do the process of convert displayLabel.text! to Double so that we can use it every time we want to convert.
        get{
            // guard means if we can't convert displayLabel.text! to Double successfully, then throw fatal error
            // in this case we can understand this if Double(displayLabel.text!) is nil/invalid then fatal error
            // but if it works, then store that value into number
            guard let number = Double(displayLabel.text!) else {
                fatalError("Error converting from String to Double")
            }
            return number
        }
        
        set{
            // this happens when we give displayValue new value
            // set the displayLabel.text to display the new value of displayValue
            // because displayValue is Double, we need to cast it to String.
            displayLabel.text = String(newValue)
        }
    }
    
    // instance of CalculatorLogic()
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //What should happen when a non-number button is pressed
        
        // set isFinishTypingNumber is true again
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue) // set "number" of Model to be displayValue
        
        if let calcMethod = sender.currentTitle{
            print(calcMethod)
            
            // result is output of calculate() which is a optional Double
            //            guard let result = calculator.calculate(symbol: calcMethod) else {
            //                fatalError("Error, result of calculate() is nil/invalid")
            //            }
            if let result = calculator.calculate(symbol: calcMethod){
                displayValue = result // when displayValue has new value, it triggers set{} --> displayLabel.text will display new text on screen.
                print(displayValue)
            }
        }
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        
        // sender.currentTitle is optional
        // sender.currentTitle is the title of the button
        if let numValue = sender.currentTitle{
            if isFinishedTypingNumber == true{
                displayLabel.text = numValue
                isFinishedTypingNumber = false
                print(displayValue)
            }else{ // if isFinishedTypingNumber is false, we can add more text to current title.
                // add new text to current text and display them all
                
                //DEALING WITH DECIMAL PLACE
                if numValue == "." {
                    
                    // check if after we round down, the round-down value equals original value, then isInt is true
                    let isInt = floor(displayValue) == displayValue
                    
                    // if isInt is false, then we stop.
                    if !isInt {
                        return // stop here, can't go down to the append all texts
                    }
                }
                
                // append current text to text already there and display them all
                displayLabel.text = displayLabel.text! + numValue
                print(displayValue)
            }
            
        }
    }
    
}

/*
 04/30/2020: so when we first click on 1 number, we check isFinishedTypingNumber is true, if so we set it to false so when we click on 1 number again, it will be added to the current title. When we click on non-number buttons, isFinishedTypingNumber is set back to true so that we can start writing new number.
 
 05/01/2020: Dealing with decimal place:
 -
 */
