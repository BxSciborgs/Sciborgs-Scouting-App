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
    var teamTemplate: [String:AnyObject]!
    var roundTemplate: [String:AnyObject]!
    
    var pfObject: PFObject!
    var pfQuery: PFQuery!
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
        teamTemplate = getJSON("TeamTemplate")
        roundTemplate = getJSON("RoundTemplate")
        
        //teamTemplate[0]["number"] = 10
        //print(teamTemplate)
//        pfObject = PFObject(className: "Templates")
//        pfObject.addObject(teamTemplate!, forKey: "TeamTemplate")
//        pfObject.addObject(roundTemplate!, forKey: "RoundTemplate")
//        pfObject!.saveInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
//            if(succeeded) {
//                print("Sent JSON")
//            }else {
//                print("Didnt send: \(error?.description)")
//            }
//        }
        
        print(getTeamTemplate())
        print(getRoundTemplate())
    }
    
    func getTeamTemplate() -> JSON {
        var jsonObject: JSON = nil
        
        pfQuery = PFQuery(className: "Templates")
        pfQuery.whereKeyExists("TeamTemplate")
        pfQuery.getFirstObjectInBackgroundWithBlock {(object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                let pfObject = object!.objectForKey("TeamTemplate")! //info retrieved from databse

                jsonObject = JSON(pfObject[0])
                } else {
                print("Didn't find anything")
            }
        }
        return jsonObject
    }
    
    func getRoundTemplate() -> JSON {
        var jsonObject: JSON = nil
        
        pfQuery = PFQuery(className: "Templates")
        pfQuery.whereKeyExists("RoundTemplate")
        pfQuery.getFirstObjectInBackgroundWithBlock {(object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                let pfObject = object!.objectForKey("RoundTemplate")! //info retrieved from databse
                
                jsonObject = JSON(pfObject[0])
            } else {
                print("Didn't find anything")
            }
        }
        return jsonObject
    }
    
    func getJSON(fileName: String!) -> [String:AnyObject] {
        var jsonData: NSData!
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        jsonData = NSData(contentsOfFile: filePath!)
        return JSON(data: jsonData).dictionaryObject!
    }
    
}
