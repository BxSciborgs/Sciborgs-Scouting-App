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

public enum ParseClass: String {
    case Teams = "Teams"
    case TeamsTest = "TeamsTEST"
}
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
                print("Pushed round succesfully")
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
    
    static func createNewClass(className: String) {
        BlueAlliance.sendRequestTeams(CompetitionCode.Javits, completion: {(teamNames: [String], teamNumbers: [Int])->Void in
            for i in 0..<teamNames.count {
                let object = PFObject(className: className)
                object["teamNumber"] = teamNumbers[i]
                object["teamKey"] = "frc\(teamNumbers[i])"
                object["teamNickname"] = teamNames[i]
                object.saveInBackground()
            }
        })
    }
    
}