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
    var teamTemplate: [String: AnyObject]!
    var roundTemplate: [String: AnyObject]!
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
        teamTemplate = getJSON("TeamTemplate").dictionaryObject
        roundTemplate = getJSON("RoundTemplate").dictionaryObject
    }
    
    func getJSON(fileName: String!) -> JSON {
        var jsonData: NSData!
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        jsonData = NSData(contentsOfFile: filePath!)
        return JSON(data: jsonData)
    }
}
