//
//  ViewController.swift
//  Take 5 Numbers
//
//  Created by Patrick Moraitis on 4/19/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var pickToolbar: UIToolbar!
    
    @IBOutlet var collectionView: [UICollectionView]!
        
    @IBAction func resetPick(sender: UIBarButtonItem) {
        
        keyToggle = []
        keysPressed = 0
        for var i=1; i<=maxKeys; ++i {keyToggle.append(false)}
        
        updateNumbersPicked()
    }
    
    
    //constants for the UICollectionViewCell ReuseIdentifier, must match the value entered via IB
    let keyReuseID = "numKey"
    let pickReuseID = "pickCell"
    
    //constants related to wager instructions, in this case pick 5 #s out of 39
    //modify for lotto games with different number ranges (NY Pick 10 rules for ex., pick 10 out of 80)
    let maxKeys:Int = 39
    let maxPick:Int = 5
    
    //colors
    let teal = UIColor(red: 0.0431, green: 0.5569, blue: 0.5333, alpha: 1.0)
    let bluegrey = UIColor(red: 0.6667, green: 0.749, blue: 0.7451, alpha: 1.0)
    
    //declare 2 empty arrays for now. later, both arrays length will equal 'maxKeys' (39)
    //will hold all whole numbers between 1 and maxKeys (39) used to create the number picker grid
    var keyArray: [Int] = []
    //will hold maxKeys (39) on/off switches that map to key array. defaults to all zeros
    var keyToggle: [Bool] = []
    
    //holds the numbers currently picked, output version of keyToggle. defaults to all zeros
    var numbersPicked: [Int] = []
    
    //holds number of how many numbers are selected, defaults with 0 and must not exceed maxPick (5)
    var keysPressed: Int = 0
    
    //define arrays with loops
    required init?(coder aDecoder: NSCoder) {
        
        for var i=1; i<=maxKeys; ++i {
            keyArray.append(i)//should only be defined once, static array
            keyToggle.append(false)
        }
        
        for var i=0; i<maxPick; ++i {
            numbersPicked.append(0)
        }
        
        //keyArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39]
        //keyToggle: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        //keyToggle: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
        
        //print(keyArray);print(keyToggle)
        
        super.init(coder: aDecoder)
    }
    
    
//BEGIN UICollectionViewDataSource protocol - https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionViewDataSource_protocol/
    
    // REQUIRED - tells the collectionview the amount of viewcells, in this case the length of keyArray
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        //print the tag of the collectionView currently in scope
        //with Take5 rules, 39 print statements of 39 followed by 5 prints of 5
        //print(collectionView.tag)
        
        if(collectionView.tag == maxKeys){
            //print("numberOfItemsInSection = \(maxKeys)")
            return maxKeys
        }
        else if(collectionView.tag == maxPick){
            //print("numberOfItemsInSection = \(maxPick)")
            return maxPick
        }
        else{
            print("error")
            return 0
        }
    }
    
    
    // REQUIRED - define and the draw the cells at each item's index
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //draws the number picker keyboard
        if(collectionView.tag == maxKeys){
        
            //creates all keys as! a custom class and stores it all in one an object
            let allKeyCells = collectionView.dequeueReusableCellWithReuseIdentifier(keyReuseID, forIndexPath: indexPath) as! NumKeyCViewCell
            
            //NumKeyCViewCell class has an outlet to the cell's text label, keyLabel
            //sets the numbers button text with that button's
            allKeyCells.keyLabel.text =  "\(keyArray[indexPath.item])"
            
            ///text color is hot pink #ed3a8e
            allKeyCells.keyLabel.textColor = UIColor(red: 0.9294, green: 0.2275, blue: 0.5569, alpha: 1.0)
            
            // apply other design changes to all keys by calling a single object
            allKeyCells.keyLabel.font = UIFont.boldSystemFontOfSize(22)
            allKeyCells.backgroundColor = UIColor.whiteColor()
            allKeyCells.layer.borderColor = UIColor.whiteColor().CGColor
            allKeyCells.layer.borderWidth = 2
            allKeyCells.layer.cornerRadius = 8
            
            //update pressed cell style to selected
            if keyToggle[indexPath.item]{
                allKeyCells.backgroundColor = UIColor(red: 0.4392, green: 0.149, blue: 0.2784, alpha: 1.0) //#702647
                allKeyCells.keyLabel.textColor = UIColor.whiteColor()
            }
            
            //print(allKeyCells)
            return allKeyCells
        
        }
        //draws the selected pick summary
        else if(collectionView.tag == maxPick){

            if(keysPressed == 5){
                //#0b8e88 teal
                collectionView.backgroundColor = teal
            }else{
                //#aabfbe blue grey
                collectionView.backgroundColor = bluegrey
            }
        
            let allPickCells = collectionView.dequeueReusableCellWithReuseIdentifier(pickReuseID, forIndexPath: indexPath) as! NumKeyCViewCell
            
            allPickCells.pickLabel.text =  "\(numbersPicked[indexPath.item])"
            allPickCells.layer.borderColor = UIColor.whiteColor().CGColor
            allPickCells.layer.borderWidth = 2
            allPickCells.layer.cornerRadius = 30
            
            if numbersPicked[indexPath.item] == 0 {
                allPickCells.pickLabel.textColor = UIColor.whiteColor()
                allPickCells.backgroundColor = bluegrey
            }
            else{
                allPickCells.pickLabel.textColor = UIColor.whiteColor()
                allPickCells.backgroundColor = teal
            }
            
            //print(allPickCells)
            return allPickCells
            
        }
        else{
            print("App will crash because returned object is undefined")
            //print(UICollectionViewCell())
            return UICollectionViewCell()
        }

    }
//END UICollectionViewDataSource protocol
    
//BEGIN UICollectionViewDelegate protocol - https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionViewDelegate_protocol/
    
    //function runs when user taps on a number cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        if collectionView.tag == maxKeys {
            
            //
                /*
            print(collectionView.tag)
            print(indexPath.section)
            print(indexPath.row)
            print(indexPath.item)
            print(collectionView.cellForItemAtIndexPath(indexPath))
            print("---------")
            print (keyToggle.count)
            print (keyArray.count)
            print(keysPressed)
            print("You picked #\(indexPath.item+1)!")
            //
                */
            
            //PICK NUMBER IF the cell selected is not picked and total numbers picked is 5 or less
            if !keyToggle[indexPath.item] && keysPressed < maxPick {
                
                //update variables related to numbers picked
                keyToggle[indexPath.item] = true
                keysPressed++
                
                updateNumbersPicked()
            }
                
            //UNPICK NUMBER IF the cell was already selected
            else if keyToggle[indexPath.item] {
                keyToggle[indexPath.item] = false
                keysPressed--
                
                updateNumbersPicked()
            }
            //ERROR ALERT IF picking more than 5 numbers
            else if keysPressed>=maxPick{
                let take6error = UIAlertController(title: "One too many!", message: "Pick must have \(maxPick) numbers", preferredStyle: UIAlertControllerStyle.Alert)
                take6error.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(take6error, animated: false, completion: nil)
            }
            else{
                print("¿¿¿unknown error???")
            }
        }
        else if collectionView.tag == maxPick {
            //print("pick cell clicked, nothing else should happen")
        }
        else{print("unknown clicked")}
    }
    
//END UICollectionViewDelegate protocol
    
    //function to translate data from number keyboard to picked numbers view, updates collectionView
    func updateNumbersPicked() {
        
        //resets array to empty
        for var k=0; k<maxPick; ++k {
            numbersPicked[k] = 0
        }
        
        // i increments by 1 each time a number is added to numbersPicked array
        var i = 0;
        
        //loop through the keyToggle array and move keys that are pressed to the numbersPicked array
        //sorts the numbers in ascending order, writing from left to right, empty cells equal 0
        for var j=0; j<maxKeys; ++j {
            if keyToggle[j] {
                numbersPicked[i] = j+1
                i++
            }
        }
        
        //update the view with reloadData
        collectionView.forEach {(collectionView) -> () in
            collectionView.reloadData()
        }

    }
    
}//close class



