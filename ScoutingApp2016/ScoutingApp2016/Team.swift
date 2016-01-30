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
    
    public var currentRound: Round!
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
    }
    
    func sendSkeleton() { //sends empty teamtemplate (must be done initially when creating each team)
        DBManager.pull("Templates", rowKey: "templateType", rowValue: "TeamTemplate", finalKey: "templateJSON", completion: {(result)->Void in
            var teamJSON = result
            DBManager.push("Teams", rowKey: "teamNumber", rowValue: self.teamNumber, finalKey: "TeamInfo", object: teamJSON.dictionaryObject!)
        })
    }
    
    func createRound(roundNum: Int) {
        currentRound = Round(roundNumber: roundNum)
    }
    
    func submitCurrentRound() {
        DBManager.pull("Teams", rowKey: "teamNumber", rowValue: self.teamNumber, finalKey: "TeamInfo", completion: {(result)->Void in
            var teamJSON = result
            teamJSON["rounds"].arrayObject?.append(self.currentRound.getRound()) //appends current round being edited
            DBManager.push("Teams", rowKey: "teamNumber", rowValue: self.teamNumber, finalKey: "TeamInfo", object: teamJSON.dictionaryObject!)
        })
    }
}
