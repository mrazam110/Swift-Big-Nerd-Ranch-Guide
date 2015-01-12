//
//  BNRItemStore.swift
//  Chap8
//
//  Created by PanaCloud on 7/18/14.
//  Copyright (c) 2014 PanaCloud. All rights reserved.
//

import UIKit

let GlobalStoreShare = BNRItemStore()
class BNRItemStore: NSObject {
   
    //Notice that this is a class method
    class var sharedStore:BNRItemStore{
        return GlobalStoreShare
    }
    
    var _privateItems = [BNRItem]()
    
    var allItems:[BNRItem]{
    return _privateItems
    }
    
    func removeItem(item: BNRItem) {
        for (index, element) in enumerate(_privateItems) {
            if element === item {
                _privateItems.removeAtIndex(index)
            }
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        _privateItems.moveObjectAtIndex(fromIndex, toIndex: toIndex)
    }
    
    func createItem() -> BNRItem {
        let item = BNRItem.randomItem()
        _privateItems.append(item)
        return item
    }
    
    
}


extension Array {
//    func contains(#object:AnyObject) -> Bool {
//        return self.bridgeToObjectiveC().containsObject(object)
//    }
//    
//    func indexOf(#object:AnyObject) -> Int {
//        return self.bridgeToObjectiveC().indexOfObject(object)
//    }
    
    mutating func moveObjectAtIndex(fromIndex: Int, toIndex: Int) {
        if ((fromIndex == toIndex) || (fromIndex > self.count) ||
            (toIndex > self.count)) {
                return
        }
        // Get object being moved so it can be re-inserted
        let object = self[fromIndex]
        
        // Remove object from array
        self.removeAtIndex(fromIndex)
        
        // Insert object in array at new location
        self.insert(object, atIndex: toIndex)
    }
}
