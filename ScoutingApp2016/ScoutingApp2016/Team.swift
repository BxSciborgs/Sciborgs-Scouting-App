//
//  Team.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 1/20/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import Parse
import Bolts

class Team {
    
    var teamNumber: Int!
    var teamTemplate: JSON?
    var roundTemplate: JSON?
    var teamJSON: JSON?
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
        
        query("Templates", key: "TeamTemplate", completion: {(result)->Void in
            var json = result
            print(json["rounds"])
        })
    }
    
    func query(className: String, key: String, completion:(result:JSON)->Void) {
        let query = PFQuery(className: className)
        query.orderByDescending("createdAt")
        query.whereKeyExists(key)
        query.getFirstObjectInBackgroundWithBlock {(obj: PFObject?, error: NSError?) -> Void in
            if error == nil {
                print("Found \(key)")
                completion(result: JSON(obj!.objectForKey(key)!))
            } else {
                print("\(key) not found")
            }
        }
    }
    
    
    func getJSON(fileName: String!) -> [String:AnyObject] {
        var jsonData: NSData!
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        jsonData = NSData(contentsOfFile: filePath!)
        return JSON(data: jsonData).dictionaryObject!
    }
    
}
