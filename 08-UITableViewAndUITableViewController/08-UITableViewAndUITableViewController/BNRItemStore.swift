//
//  BNRItemStore.swift
//  08-UITableViewAndUITableViewController
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
    
    func allItemsMoreThanFif() -> [BNRItem]{
        return _privateItems.filter({$0.valueInDollars > 50})
    }
    
    func allItemsLessThanFif() -> [BNRItem]{
        return _privateItems.filter({$0.valueInDollars <= 50})
    }
    
    func createItem() -> BNRItem{
        let item = BNRItem.randomItem()
        _privateItems.append(item)
        return item
    }
    
}