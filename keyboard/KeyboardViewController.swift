//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by Elizabeth Simonian on 2/8/16.
//  Copyright © 2016 Elizabeth Simonian. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var firstNumber = 0
    var secondNumber = 0
    var operation = ""
    
    var keyboardView: UIView!
    var calculateAgain = true
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var calculatorLable: UILabel!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadKeyboardFunction()
        clear()

    }
    
    @IBAction func calculate() {
        
        if firstNumber != 0 && operation != "" && calculatorLable.text != "" {
            
            if let anInt = Int(calculatorLable.text!) {
                
                secondNumber = anInt
                
            }
            
            if secondNumber != 0 && calculateAgain == true {
                
                calculateAgain = false
                submitButton.enabled = true
                
                print(firstNumber)
                print(secondNumber)
                print(operation)
                
                if operation == "+" {
                    
                    addition(firstNumber, intTwo: secondNumber)
                    updateLabel()
                    
                } else if operation == "-" {
                    
                    subtract(firstNumber, intTwo: secondNumber)
                    updateLabel()
                    
                } else if operation == "x" {
                    
                    multiply(firstNumber, intTwo: secondNumber)
                    updateLabel()
                    
                } else if operation == "/" {
                    
                    divide(firstNumber, intTwo: secondNumber)
                    updateLabel()
                }
            }
            
        }
        
    }
    
    func updateLabel() {
        
        calculatorLable.text = String(answer)
    }
    
    @IBAction func operationPressed(sender: UIButton!) {
        
        let operationPressed = sender.titleLabel?.text
        
        if firstNumber == 0 && secondNumber == 0 && calculatorLable != "" && operation == "" {
            
            if calculatorLable.text != "" {
                
                if let operationTouch = operationPressed {
                    
                    operation = operationTouch
                }
                
                if let anInt = Int(calculatorLable.text!) {
                    
                    firstNumber = anInt
                    calculatorLable.text = ""
                    
                }
            }
           
            print("\(firstNumber): \(operation)")
            
        } else {
            
            print("do nothing")
        }
    }
    
    @IBAction func submit() {
        
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(calculatorLable.text!)
        
    }
    @IBAction func hideKeyboard() {
        
        dismissKeyboard()
        
    }
    
    @IBAction func deleteText() {
        
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.deleteBackward()
    
    }
    
    @IBAction func goToNextKeyboard() {
        
        advanceToNextInputMode()
        
    }
    
    @IBAction func clear() {
        
        calculatorLable.text = ""
        firstNumber = 0
        secondNumber = 0
        operation = ""
        calculateAgain = true
        submitButton.enabled = false
        
    }
    
    @IBAction func numberPressed(sender: UIButton!) {
        
        let numberPressed = sender.titleLabel?.text
        
        if firstNumber != 0 && secondNumber != 0 {
            
        } else {
            
            calculatorLable.text = calculatorLable.text! + numberPressed!
        }
        
    }
    
    func loadKeyboardFunction() {
        
        let keyboardNib = UINib(nibName: "View", bundle: nil)
        keyboardView = keyboardNib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.backgroundColor = keyboardView.backgroundColor
        view.addSubview(keyboardView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
    }

}
