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
    var teamJSONS: [AnyObject!]
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
        
        teamJSONS = []
    }
    
    public func queryAllRounds() {
        self.queryRound(1)
    }
    
    public func queryRound(roundNum: Int!) {
        let parseObject = PFObject(className: "Team\(self.teamNumber)")
        
        teamQuery = PFQuery(className: "Team\(self.teamNumber)")
        teamQuery.getObjectInBackgroundWithId("JWzUYHy8DZ") {
            (round: PFObject?, error: NSError?) -> Void in
            if error == nil && round?.objectForKey("Round\(roundNum)") != nil {
                print("Found Round\(roundNum)")
                
                self.teamJSONS.append(round!.objectForKey("Round\(roundNum)"))
                print(self.teamJSONS)
                
                let nextRound = roundNum + 1
                self.queryRound(nextRound)
            } else {
                print("Round \(roundNum) not played yet")
            }
        }
    }
    
    public func getJSONS() -> [AnyObject!] {
        return self.teamJSONS
    }
}