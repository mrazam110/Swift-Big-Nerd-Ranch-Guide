//
//  BNRItemStore.swift
//  UINavigationController10
//
//  Created by Raza Master on 1/3/15.
//  Copyright (c) 2015 raza. All rights reserved.
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
        var a = _privateItems[fromIndex]
        _privateItems[fromIndex] = _privateItems[toIndex]
        _privateItems[toIndex] = a
    }
    
    func createItem() -> BNRItem {
        let item = BNRItem.randomItem()
        _privateItems.append(item)
        return item
    }
    
    
}