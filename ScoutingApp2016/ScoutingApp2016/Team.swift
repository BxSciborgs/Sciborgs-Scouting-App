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
    
    var pfObject: PFObject!
    var pfQuery: PFQuery!
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
        
        teamTemplate = nil
        roundTemplate = nil
        
        queryRoundTemplate()
        queryTeamTemplate()
    }
    
    func queryTeamTemplate() {
        pfQuery = PFQuery(className: "Templates")
        pfQuery.whereKeyExists("TeamTemplate")
        
        var pfObject: AnyObject! = nil
        
        pfQuery.getFirstObjectInBackgroundWithBlock {(object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                pfObject = object!.objectForKey("TeamTemplate")! //info retrieved from databse

                let jsonObject = JSON(pfObject[0])
                self.teamTemplate = jsonObject
            } else {
                print("Didn't find anything")
            }
        }
    }
    
    func printTemplate(template: JSON) {
        print(template)
    }
    
    func queryRoundTemplate() {
        var jsonObject: JSON = nil
        
        pfQuery = PFQuery(className: "Templates")
        pfQuery.whereKeyExists("RoundTemplate")
        pfQuery.getFirstObjectInBackgroundWithBlock {(object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                let pfObject = object!.objectForKey("RoundTemplate")! //info retrieved from databse
                
                jsonObject = JSON(pfObject[0])
                self.roundTemplate = jsonObject
            } else {
                print("Didn't find anything")
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
