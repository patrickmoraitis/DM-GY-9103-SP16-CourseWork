//
//  ViewController.swift
//  Color picker
//
//  Created by Patrick Moraitis on 2/9/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

import UIKit

class ColorChangeViewController: UIViewController {
    
    
    @IBOutlet var myView: UIView!
    @IBOutlet var myLabel: UILabel!
    
    var colorDict: [String:[UIColor]] = [
        
        "akshay": [UIColor(red: 0, green: 0, blue: 0, alpha: 1)],
        "paulina":[UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)],
        "carlos": [UIColor(red: 0, green: 0.929, blue: 1, alpha: 1)],
        "jayson": [UIColor(red: 0, green: 0.165, blue: 0.361, alpha: 1)],
        "nithi": [UIColor(red:1, green: 0, blue: 0, alpha: 1)],
        "lorenzo": [UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1)],
        "david": [UIColor(red:1, green: 0.714, blue: 757, alpha: 1), UIColor(red:0.729, green: 0.855, blue: 333, alpha: 1)],
        "derek": [UIColor(red:0.2, green: 0.275, blue: 0.349, alpha: 1)],
        "yuchi": [UIColor(red:1, green: 0.337, blue: 0, alpha: 1)],
        "patrick": [UIColor(red: 0.141, green: 0.251, blue: 0.949, alpha: 1)]
        
    ]
    
    @IBAction func fieldChanged(textField: UITextField) {
        var colorArray = colorDict[(textField.text?.lowercaseString)!]
        
        if colorArray != nil {
            if colorArray!.count > 1 {
                let randomIndex = Int(arc4random_uniform(UInt32(colorArray!.count)))
                UIView.animateWithDuration(1.0, animations:{
                    self.myView.backgroundColor = colorArray![randomIndex]
                })
            }
            else {
                UIView.animateWithDuration(1.0, animations:{
                    self.myView.backgroundColor = colorArray![0]
                })
            }
            myLabel.hidden = true
        }
        else {
            myView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            myLabel.hidden = false
        }
    }
    
    @IBAction func makeMyColor(myButton: UIButton){
        

        
    }
    
}
    




