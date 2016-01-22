//
//  DBManager.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 1/22/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import Parse
import Bolts

class DBManager {
    
    static func query(className: String, key: String, completion:(result:JSON)->Void) {
        let query = PFQuery(className: className)
        query.orderByDescending("createdAt")
        query.getFirstObjectInBackgroundWithBlock {(obj: PFObject?, error: NSError?) -> Void in
            if error == nil {
                print("Found \(key)")
                completion(result: JSON(obj!.objectForKey(key)!))
            } else {
                print("\(key) not found")
            }
        }
    }
    
    static func push(className: String, key: String, object: [String: AnyObject]) {
        let pfObject = PFObject(className: className)
        pfObject[key] = object
        pfObject.saveInBackground()
    }
    
//    static func getJSON(fileName: String!) -> [String:AnyObject] {
//        var jsonData: NSData!
//        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
//        jsonData = NSData(contentsOfFile: filePath!)
//        return JSON(data: jsonData).dictionaryObject!
//    }
    
}