//
//  TeamProfile.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import Parse
import Bolts


// Information for ALL ROUNDS 
public class TeamProfile {
    
    var teamNumber: Int!
    
    var teamQuery: PFQuery!
    var teamJSONS: [JSON!]
    var allRoundsJSON: [String: AnyObject!]
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
        
        teamJSONS = []
        allRoundsJSON = ["Team" : teamNumber]
    }
    
    //Will recursively search for all rounds
    public func queryAllRounds() {
        queryRound(1, allRounds: true)
    }
    
    //Searches database for a specific round
    public func queryRound(roundNum: Int!, allRounds: Bool!) {
        teamQuery = PFQuery(className: "Team\(teamNumber)")
        teamQuery.whereKeyExists("Round\(roundNum)")
        teamQuery.getFirstObjectInBackgroundWithBlock {(round: PFObject?, error: NSError?) -> Void in
            if error == nil {
                print("Found Round\(roundNum) \n")
                
                let roundInfo = round!.objectForKey("Round\(roundNum)") //info retrieved from databse
                
                let roundJSON = JSON(roundInfo!) //info converted to JSON
   
                var jsonString: String = String(roundJSON)
                jsonString.trim("[")
                jsonString.trim("]")
                
                let fixedJSON = self.convertStringToDictionary(jsonString)
                self.allRoundsJSON["Round\(roundNum)"] = fixedJSON
                print("Round \(roundNum): \(self.getRound(roundNum))")
                print("Round \(roundNum) Comment: \(self.getRound(roundNum)["Comment"]!) \n")
                
                let nextRound = roundNum + 1
                
                if(allRounds == true) {
                    self.queryRound(nextRound, allRounds: true) //recursively searching if next round exists
                }else {
                    self.allRoundsJSON = ["Team" : self.teamNumber] //ensures that only the specific JSON is in the array when getAllRound() is called
                }

            } else {
                print("\nRound \(roundNum) not played yet")
            }
        }
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    public func getAllRounds() -> [String: AnyObject!] {
        return allRoundsJSON
    }
    
    public func getRound(round: Int!) -> [String: AnyObject!] {
        return allRoundsJSON["Round\(round)"]! as! [String : AnyObject!]
    }
}