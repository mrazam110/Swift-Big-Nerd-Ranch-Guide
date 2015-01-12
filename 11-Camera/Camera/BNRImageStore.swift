//
//  BNRImageStore.swift
//  chap11
//
//  Created by PanaCloud on 7/22/14.
//  Copyright (c) 2014 PanaCloud. All rights reserved.
//

import UIKit

let ImgGlobalStoreShare = BNRImageStore()

class BNRImageStore: NSObject {
    
    var dictionary = NSMutableDictionary()
    
    class var sharedStore:BNRImageStore{
        return ImgGlobalStoreShare
    }
    
    func setImage(image: UIImage, forKey key: String){
        //self.dictionary.setObject(image, forKey: key)
        self.dictionary[key] = image
    }
    
    func imageForKey(key: String) -> UIImage{
        //return self.dictionary.objectForKey(key) as UIImage
        var result:UIImage? = self.dictionary[key] as? UIImage
        if((result) == nil){
            return UIImage()
        }else{
            return result!
        }
    }
    
    func deleteImageForKey(key: String){
        if(key.isEmpty){
            return
        }
        self.dictionary.removeObjectForKey(key)
    }
}
