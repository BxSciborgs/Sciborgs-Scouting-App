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

public class TeamProfile {
    
    var teamNumber: Int!
    
    var teamQuery: PFQuery!
    var teamPFObjects: [PFObject!]
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
        
        teamPFObjects = [nil]
    }
    
    public func queryAllRounds() {
        self.queryRound(1)
    }
    
    public func queryRound(roundNum: Int!) {
        teamQuery = PFQuery(className: "Team\(self.teamNumber)")
        teamQuery.getObjectInBackgroundWithId("Round\(roundNum)") {
            (round: PFObject?, error: NSError?) -> Void in
            if error == nil && round != nil {
                print("Found Round\(roundNum)")
                self.teamPFObjects.append(round)

                let nextRound = roundNum + 1
                self.queryRound(nextRound)
            } else {
                print("Round not played yet")
            }
        }
    }
    
    public func getPFObjects() -> [PFObject!] {
        return teamPFObjects
    }
    public func getJSONS() -> [String] {
        var jsons: [String] = [""]
        
        for pfObject in getPFObjects() {
            jsons.append(pfObject!.description)
        }
        return jsons
    }
}