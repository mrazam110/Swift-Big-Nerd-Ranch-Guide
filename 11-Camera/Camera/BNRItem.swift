//
//  BNRItem.swift
//  Chap8
//
//  Created by PanaCloud on 7/18/14.
//  Copyright (c) 2014 PanaCloud. All rights reserved.
//

import UIKit

class BNRItem: NSObject {
   
    var itemName: String
    var serialNumber: String
    var valueInDollars: Int
    var dateCreated: NSDate
    var itemKey:String
    
    override var description: String {
    return "\(itemName) (\(serialNumber)): Worth $\(valueInDollars), recorded on \(dateCreated)"
    }
    
    init(itemName name: String, valueInDollars value: Int, serialNumber sNumber: String) {
        // Give the instance variables initial values
        itemName = name
        serialNumber = sNumber
        valueInDollars = value
        dateCreated = NSDate()
        
        //Create an NSUUID object - and get its string representation
        var uuid = NSUUID()
        var key = uuid.UUIDString
        itemKey = key
        
        super.init()
    }
    
    convenience init(itemName name: String) {
        self.init(itemName: name, valueInDollars: 0, serialNumber: "")
    }
    
    convenience override init() {
        self.init(itemName: "", valueInDollars: 0, serialNumber: "")
    }
    
    // A class method for the type Item itself, not Item instances
    class func randomItem() -> BNRItem {
        let randomAdjectiveList = ["Fluffy", "Rusty", "Shiny"]
        let randomNounList = ["Bear", "Spork", "Mac"]
        
        // Get the index of a random adjective/noun from the lists
        let adjectiveIndex = Int(arc4random() % UInt32(randomAdjectiveList.count))
        let nounIndex = Int(arc4random() % UInt32(randomNounList.count))
        
        let randomName = "\(randomAdjectiveList[adjectiveIndex]) \(randomNounList[nounIndex])"
        
        let randomValue = Int(arc4random() % 100)
                let randomSerialNumber = "0\(arc4random() % 10)A\(arc4random() % 26)0\(arc4random() % 10)"
        
        return BNRItem(itemName: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
    }
    
}

