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
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
        
        teamJSONS = []
    }
    
    //Will recursively search for all rounds
    public func queryAllRounds() {
        queryRound(1, allRounds: true)
    }
    
    //Searches database for a specific round
    public func queryRound(roundNum: Int!, allRounds: Bool!) {        
        teamQuery = PFQuery(className: "Team\(teamNumber)")
        teamQuery.whereKeyExists("Round\(roundNum)")
        teamQuery.getFirstObjectInBackgroundWithBlock {
            (round: PFObject?, error: NSError?) -> Void in
            if error == nil {
                print("Found Round\(roundNum)")
                
                let roundInfo = round!.objectForKey("Round\(roundNum)") //info retrieved from databse
                let roundJSON = JSON(roundInfo!) //info converted to JSON
                print(roundJSON)
                
                let nextRound = roundNum + 1
                if(allRounds == true) {
                    self.queryRound(nextRound, allRounds: true) //recursively searching if next round exists
                }else {
                    self.teamJSONS.removeAll() //ensures that only the specific JSON is in the array when getJSONS() is called
                }
                self.teamJSONS.append(roundJSON) //adds JSON to array
            } else {
                print("Round \(roundNum) not played yet")
            }
        }
    }
    
    //returns array full of round JSONS
    public func getJSONS() -> [JSON!] {
        return self.teamJSONS
    }
}