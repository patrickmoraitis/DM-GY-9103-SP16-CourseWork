//
//  ViewController.swift
//  Take 5 Numbers
//
//  Created by Patrick Moraitis on 4/19/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //var keyArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39"]
    //var keyToggle = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    
    let keyReuseID = "numKey"
    
    var keyArray: [Int] = []
    var keyToggle: [Int] = []
    var keysPressed: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        
        for var i=1; i<=39; ++i {
            keyArray.append(i)
            keyToggle.append(0)
        }
        
        //print(keyArray2);print(keyToggle2)
        
        super.init(coder: aDecoder)
    }


    
//BEGIN UICollectionViewDataSource protocol - https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionViewDataSource_protocol/
    
    // REQUIRED - tells the collectionview the amount of viewcells, in this case the length of keyArray
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(keyArray.count)
        return keyArray.count
    }
    
    
    // REQUIRED - define and the draw the cells at each item's index
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // creates all keys as! a custom class and stores it all in one an object 
        let allKeyCells = collectionView.dequeueReusableCellWithReuseIdentifier(keyReuseID, forIndexPath: indexPath) as! NumKeyCViewCell
        
        // custom class has an outlet the the cell's text label, sets the keyArray values to each key
        allKeyCells.keyLabel.text =  "\(self.keyArray[indexPath.item])"
        
        ///text color is #ed3a8e
        allKeyCells.keyLabel.textColor = UIColor(red: 0.9294, green: 0.2275, blue: 0.5569, alpha: 1.0)
        
        allKeyCells.keyLabel.font = UIFont.boldSystemFontOfSize(22)
        
        // apply other design changes to all keys by calling a single object
        allKeyCells.backgroundColor = UIColor.whiteColor()
        allKeyCells.layer.borderColor = UIColor.grayColor().CGColor
        allKeyCells.layer.borderWidth = 2
        allKeyCells.layer.cornerRadius = 8
        
        //print(allKeyCells)
        return allKeyCells
    }
    
//BEGIN UICollectionViewDelegate protocol - https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionViewDelegate_protocol/
    
    // change background color when user touches cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        let pressedKey = collectionView.cellForItemAtIndexPath(indexPath) as! NumKeyCViewCell
        
        //select number
        if(keyToggle[indexPath.item+1] == 0){
            pressedKey.backgroundColor = UIColor(red: 0.9294, green: 0.2275, blue: 0.5569, alpha: 1.0)
            pressedKey.keyLabel.textColor = UIColor.whiteColor()
            keyToggle[indexPath.item+1] = 1
            keysPressed++
        }
        //deselect number
        else if(keyToggle[indexPath.item+1] == 1){
            pressedKey.backgroundColor = UIColor.whiteColor()
            pressedKey.keyLabel.textColor = UIColor(red: 0.9294, green: 0.2275, blue: 0.5569, alpha: 1.0)
            keyToggle[indexPath.item+1] = 0
            keysPressed--
        }

        //print(keysPressed)
        //print("You picked #\(indexPath.item+1)!")
    }

}

