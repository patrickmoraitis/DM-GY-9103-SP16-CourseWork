//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

print(NSCalendarUnit.Year)

// get the current date and time
print(NSDate())

// get the user's calendar
NSCalendar.currentCalendar()

print(NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate()))

if(NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())) != 4{
    "4 of a kind 4s"
}
