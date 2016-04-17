//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

str = "Hello swift"

let constStr = str

//constStr = "cats"

var nextYear: Int
var bodyTemp: Float
var hasPet: Bool
//var arrayOfInts: Array<Int>
var arrayOfInts: [Int]
//var dictionaryOfCountryCapitals: Dictionary<String, String>
var dictionaryOfCountryCapitals: [String:String]
var winningLotteryNumbers: Set<Int>

let number = 42
let numberStr = "42"
let numberStr2 = String(number)

let fmStation = 91.1

//let countingUp = ["uno","dos"]
var countingUp = ["uno","dos"]
let secondElement = countingUp[1]

countingUp.count

countingUp.append("tres")


//let errorElement = countingUp[2]

let emptyString = String()
emptyString.isEmpty


let emptyIntArray = [Int]()

let emptyFloatSet = Set<Float>()


let defaultNumber = Int()

let defaultBool = Bool()

let availableRooms = Set([205, 411, 413])

let defaultFloat = Float()
let floatFromLiteral = Float(3.14)

let easyPi = 3.14

let floatFromDouble = Float(easyPi)

let floatingPi: Float = 3.14

var anOptionalFloat: Float?
var optionalArrayOfStrings: [String]?
var optionalArrayOfOptionalStrings: [String?]?

var reading1: Float?
var reading2: Float?
var reading3: Float?

reading1 = 9.9
reading2 = 9.8
reading3 = 9.7

//let avgReading = (reading1+reading2+reading3) / 3
if let r1 = reading1, r2 = reading2, r3 = reading3{
   let avgReading = (reading1! + reading2! + reading3!) / 3
}else{
    let errorString = "Error, a reading is nil"
}


let nameByParkingSpace = [13: "Alice", 27: "Bob"]
let space13Assignee: String? = nameByParkingSpace[13]
let space44Assignee: String? = nameByParkingSpace[44]

if let space13Assignee = nameByParkingSpace[13] {
    print("Key 13 is assigned in the dictionary")
}


for var i = 0; i < countingUp.count; ++i {
    let string = countingUp[i]
}

let range = 0..<countingUp.count
for i in range {
    let string = countingUp[i]
}

for string in countingUp{
    
}

for (i, string) in countingUp.enumerate(){
    
}

for (space, name) in nameByParkingSpace {
    let permit = "Space \(space): \(name)"
}

enum PieType {
    
    case Apple
    case Cherry
    case Pecan

}

enum IntPieType: Int {
    
    case Apple = 0
    case Cherry
    case Pecan
    
}

let pieRawValue = IntPieType.Pecan.rawValue

if let pieType = IntPieType(rawValue: pieRawValue){
    print("cats")
}

let favoritePie = PieType.Apple

let name: String
switch favoritePie{
    
case .Apple:
    name = "Apple"
case .Cherry:
    name = "Chery"
case .Pecan:
    name = "Pecan"
    
}
