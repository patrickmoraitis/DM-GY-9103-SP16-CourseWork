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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConvertViewController did load")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //lots of great solutions here http://stackoverflow.com/questions/24070450/how-to-get-the-current-time-and-hour-as-datetime
        
        //Swift color picker https://www.ralfebert.de/snippets/ios/swift-uicolor-picker/
        
        //NSAttributedString explained http://stackoverflow.com/questions/26076054/changing-placeholder-text-color-with-swift
        
//Silver challenge - Equinox day is split equally in two (NYC usually from 7am-7pm or 7-19)
        
        //get current hour with time zone
        let hourNow = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        //print(hourNow)
        
        //test for daylight between 7:00 & 19:00 and change BG and text colors
        
        if(hourNow >= 7 && hourNow <= 19) {
            self.view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 241/255, alpha: 1.0) // #f5f2f1 soft sunshine
            //textField.textColor = UIColor.orangeColor()
            textField.attributedPlaceholder = NSAttributedString(string:"value", attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
            let isLabel:UILabel = self.view.viewWithTag(4) as! UILabel
            isLabel.textColor = UIColor.blackColor()
        }
        else{
            self.view.backgroundColor = UIColor(red: 0.1, green: 0.075, blue: 0.21, alpha: 1.0) // #31286d night sky dark blue
            //textField.textColor = UIColor.blueColor()
            textField.attributedPlaceholder = NSAttributedString(string:"value", attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
            let isLabel:UILabel = self.view.viewWithTag(4) as! UILabel
            isLabel.textColor = UIColor.whiteColor()
        }
    
    }
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fTemp: Double? {
        didSet{
            updateCelsiusLabel()
        }
    }
    
    //converts F to C
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