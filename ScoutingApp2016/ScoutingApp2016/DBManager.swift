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
    
    static func pull(className: String, rowKey: String, rowValue: AnyObject, finalKey: String, completion:(result:JSON)->Void) {
        let query = PFQuery(className: className)
        query.whereKey(rowKey, equalTo: rowValue)
        
        query.getFirstObjectInBackgroundWithBlock {(obj: PFObject?, error: NSError?) -> Void in
            if error == nil {
                let jsonObject = JSON(obj!.objectForKey(finalKey)!)
                completion(result: jsonObject)
            } else {
                
            }
        }
    }
    
    static func push(className: String, rowKey: String, rowValue: AnyObject, finalKey: String, object: [String: AnyObject]) {
        let query = PFQuery(className: className)
        query.whereKey(rowKey, equalTo: rowValue)
        
        query.getFirstObjectInBackgroundWithBlock {(obj: PFObject?, error: NSError?) -> Void in
            if error == nil {
                obj?.setObject(object, forKey: finalKey)
                obj?.saveInBackground()
            } else {
                
            }
        }
    }
        
    static func getJSON(fileName: String!) -> [String:AnyObject] {
        var jsonData: NSData!
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        jsonData = NSData(contentsOfFile: filePath!)
        return JSON(data: jsonData).dictionaryObject!
    }
    
    static func addAllTeams() {
        BlueAlliance.sendRequestTeams(CompetitionCode.Javits, completion: {(teamNames: [String], teamNumbers: [Int])->Void in
            for teamNum in teamNumbers {
                let teamProfile = Team(teamNumber: teamNum)
                teamProfile.sendSkeleton()
            }
        })
    }
    
}