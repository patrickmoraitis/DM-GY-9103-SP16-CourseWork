//
//  ConvertViewController.swift
//  WorldTrotter
//
//  Created by Patrick Moraitis on 4/18/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

//import Foundation

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fTemp: Double? {
        didSet{
            updateCelsiusLabel()
        }
    }
    
    var cTemp: Double? {
        
        if let value = fTemp {
            return (value - 32) * (5/9)
        }
        else{
            return nil
        }
    }
    
    @IBAction func inputFieldChanged(textField: UITextField) {
        //celsiusLabel.text = textField.text
        
        /*
        if let text = textField.text where !text.isEmpty{
            celsiusLabel.text = text
        }
        else{
            celsiusLabel.text = "???"
        }
        */
        
        if let text = textField.text, value = Double(text){
            fTemp = value;
        }
        else{
            fTemp = nil;
        }
    }
    
    func updateCelsiusLabel(){
        if let value = cTemp{
            //celsiusLabel.text = "\(value)"
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else{
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func closeKeyboard(sender: AnyObject){
        textField.resignFirstResponder()
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.maximumFractionDigits = 1
        nf.minimumFractionDigits = 0
        return nf
    }()
    
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
        
            //print("Current text: \(textField.text)")
            //print("Replacement text: \(string)")
            //return true
            
            let existingTextHasDecimal = textField.text?.rangeOfString(".")
            let replacementTextHasDecimal = string.rangeOfString(".")
            
            //Bronze challenge, do not allow alphabet characters
            if(string.rangeOfString(".") != nil || string.rangeOfCharacterFromSet(NSCharacterSet.letterCharacterSet()) == nil){
                if existingTextHasDecimal != nil && replacementTextHasDecimal != nil {
                    return false
                }
                else{
                    return true
                }
            }
            else{
                return false
            }

    }
    
    
}