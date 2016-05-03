//
//  ViewController.swift
//  Take 5 Numbers
//
//  Created by Patrick Moraitis on 4/19/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: [UICollectionView]!
    
    @IBOutlet var winningNumber: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var pickToolbar: UIToolbar!
    
    @IBOutlet weak var wagerButton: UIBarButtonItem!
    
    @IBAction func wagerPick(sender: UIBarButtonItem) {
        //print(numbersPicked)
        let wager = Wager(pickK: numbersPicked, dateK: dateSelected, nameK: "more cats")!
        WagerStore.sharedInstance.addWager(wager)
        
        var alertMessage: String
        var alertTitle: String
        
        if openBet {
            alertMessage = "You saved a bet on \(numbersPicked.map{ "\($0)"}.joinWithSeparator(", ")) \n for \(longStringFromDateFormat(dateSelected))"
            alertTitle = "Good luck!"
        }else{
            alertMessage = "Your bet did not win\n\nBetter luck next time!"
            alertTitle = "Results for \(stringFromDateFormat(dateSelected))"
        }
        
        let successBet = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        successBet.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(successBet, animated: false, completion: nil)
    }
    
    @IBOutlet weak var resetButton: UIBarButtonItem!
    
    @IBAction func resetPick(sender: UIBarButtonItem) {
        
        keyToggle = []
        keysPressed = 0
        for var i=1; i<=maxKeys; ++i {keyToggle.append(false)}
        
        updateNumbersPicked()
    }
    
    @IBOutlet weak var quickpickButton: UIBarButtonItem!
    
    @IBAction func quickPick(sender: UIBarButtonItem){
        
        keyToggle = []
        keysPressed = 0
        for var i=1; i<=maxKeys; ++i {keyToggle.append(false)}
        
        while keysPressed < 5 {
            
            let r = Int(arc4random_uniform(UInt32(maxKeys)))
            
            if !keyToggle[r] {
                keyToggle[r] = true
                keysPressed++
            }
        }

        //print(keyToggle)
        
        updateNumbersPicked()
        
    }
    
    
//CITE//Major thanks to my coworker and friend JG for helping me with this pop up date picker!
    
    //programmatically creates 1 views, one date picker, and a button
    
    //shadowView is a full frame UIView with a slightly transparent black color over the main UI
    //works similar to UIAlert pop ups, effectively disabling all buttons until user completes a specific prompt
    var shadowView: UIView!
    //datePickerView contains the UIDatePicker input window
    var datePickerView: UIDatePicker!
    //this button closes the date picker alert window and passed the data selected
    var datePickedButton: UIButton!
    
    //This button is found on the storyboard, upper right corner of the main page
    @IBOutlet weak var changeDateButton: UIButton!
    
    //Clicking the change date buttons opens the date picker pop up by adding 3 items to the view)
    @IBAction func showDatePicker(sender: AnyObject) {
        
        //set the view size to the same size as the main view, in this case it's practically full screen
        shadowView = UIView(frame: view.frame)
        //add a black color with 80% to make the main UI barely visible. Adds contrast to date picker, making it a stronger call to action
        shadowView.backgroundColor = UIColor.blackColor()
        shadowView.alpha = 0.8
        //add the shadowView as a subview of the main view. This shadow must come first so that date picker can be added on top of it.
        view.addSubview(shadowView)
        
        //positions and sizes the datePickerView.
            //view.center.x - (1/2 width of datepicker) centers the date picker
            //CGRectGetMaxY positions the date picker slightly below the Change Date button
        datePickerView = UIDatePicker(frame: CGRectMake(view.center.x - 180, CGRectGetMaxY(changeDateButton.frame) + 80, 360, 360))
        //add background color to the date picker
        datePickerView.backgroundColor = pink
        //change date pickers font color
        datePickerView.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        //sets picker mode to .date so user can only select whole days using wheels for month|day|year
        datePickerView.datePickerMode = .Date
        //add circular effect to datePicker by setting cornerRadius to 1/2 the width of date picker view
        datePickerView.clipsToBounds = true
        datePickerView.layer.cornerRadius = 180
        //the date format found in the data.ny.gov Take5 database
        //dataNYdateFormat.dateFormat = "MM/dd/yyyy"
        //Set minimum and maximum date of datePicker. Another scenario would be too limit dates 1 year +/- today
        datePickerView.minimumDate = dataNYdateFormat.dateFromString("01/01/2001")
        datePickerView.maximumDate = dataNYdateFormat.dateFromString("12/31/2019")
        //add date picker to the view, on top of the shadow view
        view.addSubview(datePickerView)
        
        //create and add custom button with Done label
        datePickedButton = UIButton(type: .Custom)
        datePickedButton.setTitle("Done", forState: .Normal)
        datePickedButton.frame = CGRectMake(datePickerView.center.x - 50, CGRectGetMaxY(datePickerView.frame) + 25, 100, 40)
        datePickedButton.titleLabel?.font = UIFont.boldSystemFontOfSize(36)
        
        //set action to the button
        datePickedButton.addTarget(self, action:Selector("datePicked"), forControlEvents: .TouchUpInside)
        view.addSubview(datePickedButton)
        
    }
    
    func datePicked() {
        
        dateSelected = datePickerView.date
        
        //convert data from basic string back to NSDate to remove the element of time from date
        let dateStr = stringFromDateFormat(dateSelected)
        let todayStr = stringFromDateFormat(todaysDate)
        let dateDate = dateFromStringFormat(dateStr)
        let todayDate = dateFromStringFormat(todayStr)
        
        //compares the date selected in relation to todays date
        let tenseResult: NSComparisonResult = todayDate.compare(dateDate)

        if(tenseResult == NSComparisonResult.OrderedDescending){
            dateLabel.text = "Past date " + longStringFromDateFormat(dateSelected)
            openBet = false
        }
        else if(tenseResult == NSComparisonResult.OrderedAscending){
            dateLabel.text = "Future date " + longStringFromDateFormat(dateSelected)
            openBet = true
        }
        else if(tenseResult == NSComparisonResult.OrderedSame){
            dateLabel.text = "Today is " + longStringFromDateFormat(dateSelected)
            openBet = true
        }
        
        fetchWinningNumbers()
        
        datePickedButton.removeFromSuperview()
        shadowView.removeFromSuperview()
        datePickerView.removeFromSuperview()
    }
    
//END CITE - Thanks again JG!
    
    //the date format found in the data.ny.gov Take5 database
    let dataNYdateFormat = NSDateFormatter()
    let mmddyyyy = "MM/dd/yyyy"
    
    //constants for the UICollectionViewCell ReuseIdentifier, must match the value entered via IB
    let keyReuseID = "numKeyCell"
    let pickReuseID = "pickCell"
    
    //constants related to wager instructions, in this case pick 5 #s out of 39
    //modify for lotto games with different number ranges (NY Pick 10 rules for ex., pick 10 out of 80)
    let maxKeys = 39
    let maxPick = 5
    
    //colors
    let teal = UIColor(red: 0.0431, green: 0.5569, blue: 0.5333, alpha: 1.0)
    let bluegrey = UIColor(red: 0.6667, green: 0.749, blue: 0.7451, alpha: 1.0)
    let pink = UIColor(red: 227/255, green: 81/255, blue: 152/255, alpha: 1.0)
    let britepink = UIColor(red: 252/255, green: 81/255, blue: 197/255, alpha: 1.0)
    
    //declare 2 empty arrays for now. later, both arrays length will equal 'maxKeys' (39)
    //will hold all whole numbers between 1 and maxKeys (39) used to create the number picker grid
    var keyArray = [Int]()
    
    //will hold maxKeys (39) on/off switches that map to key array. defaults to all zeros
    var keyToggle: [Bool] = []
    
    //holds the numbers currently picked, output version of keyToggle. defaults to all zeros
    var numbersPicked: [Int] = []
    
    //holds number of how many numbers are selected, defaults with 0 and must not exceed maxPick (5)
    var keysPressed = 0

    //Default date is today
    var dateSelected = NSDate()
    let todaysDate = NSDate()
    var openBet = true
    
    override func viewDidLoad() {
        
        //default date label is todays date
        dataNYdateFormat.dateStyle = NSDateFormatterStyle.LongStyle
        //dataNYdateFormat.dateFormat = "MM/dd/yyyy"
        
        dateLabel.text = "Today is " + dataNYdateFormat.stringFromDate(dateSelected)
        
        
        //define arrays with for loops
        for var i=1; i<=maxKeys; ++i {
            keyArray.append(i)//should only be defined once
            keyToggle.append(false)
        }
        
        for var i=0; i<maxPick; ++i {
            numbersPicked.append(0)
        }
        
        //print(keyArray);print(keyToggle)
        
        //keyArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39]
        //keyToggle: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        //keyToggle: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    }
    
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //if let destinationViewController = segue.destinationViewController as? WagerTableViewController {}
        
        //let dateBet = dateSelected
        //print(dateSelected);

    //}
    
    //required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
    
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
        
        if keysPressed == 0 {
            resetButton.enabled = false
            wagerButton.enabled = false
        }
        else if keysPressed == 5 {
            resetButton.enabled = true
            wagerButton.enabled = true
        }
        else{
            resetButton.enabled = true
            wagerButton.enabled = false
        }
        
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
                resetButton.enabled = true
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
            */
            
            //PICK NUMBER IF the cell selected is not picked and total numbers picked is 5 or less
            if !keyToggle[indexPath.item] && keysPressed < maxPick {
                
                //update variables related to numbers picked
                keyToggle[indexPath.item] = true
                keysPressed += 1
                
                updateNumbersPicked()
            }
                
            //UNPICK NUMBER IF the cell was already selected
            else if keyToggle[indexPath.item] {
                keyToggle[indexPath.item] = false
                keysPressed -= 1 //required for xcode 7.3
                
                updateNumbersPicked()
            }
            //ERROR ALERT IF picking more than 5 numbers
            else if keysPressed>=maxPick{
                let take6error = UIAlertController(title: "One too many!", message: "Pick exactly \(maxPick) numbers to bet", preferredStyle: UIAlertControllerStyle.Alert)
                take6error.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
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
    
    // 3 functions used for converting NSDate to String and vice versa in the right format
    
    func stringFromDateFormat(nsdate: NSDate) -> String {
        //the date format found in the data.ny.gov Take5 database
        dataNYdateFormat.dateFormat = "MM/dd/yyyy"
        
        return dataNYdateFormat.stringFromDate(nsdate)
    }
    
    func longStringFromDateFormat(nsdate: NSDate) -> String {
        //the date format found in the data.ny.gov Take5 database
        dataNYdateFormat.dateStyle = NSDateFormatterStyle.LongStyle
        
        return dataNYdateFormat.stringFromDate(nsdate)
    }
    
    func dateFromStringFormat(string: String) -> NSDate {
        //the date format found in the data.ny.gov Take5 database
        dataNYdateFormat.dateFormat = "MM/dd/yyyy"
        
        return dataNYdateFormat.dateFromString(string)!
    }

//Another huge thanks to my colleague JG for helping me fix my mess
    
    func fetchWinningNumbers() {
        
    if !openBet {
        
        //this format is required to query the API by draw_date
        dataNYdateFormat.dateFormat = "yyyy-MM-dd"
        
        let qByDrawDateURL = "https://data.ny.gov/resource/hh4x-xmbw.json?draw_date="
        
        if let url = NSURL(string: qByDrawDateURL + "\(dataNYdateFormat.stringFromDate(dateSelected))"),
            let data = NSData(contentsOfURL: url) {
        
            do
            {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                //print(jsonData)
                //print((jsonData.firstObject as! [String:String])["winning_numbers"]!)
                
                let numDrawn = (jsonData.firstObject as! [String:String])["winning_numbers"]!
                
                winningNumber.text = "The winning number for this date is \n\n \(numDrawn)"
            }
                
            catch (let error as NSError) {
                print("Error: \(error)!")
                return
            }
        }
    }
    else{
        
        winningNumber.text = "This number is yet to be drawn, visit your local lotto retailer and play today!"
        
        }
    }//Thanks JG!
    
}//close class



