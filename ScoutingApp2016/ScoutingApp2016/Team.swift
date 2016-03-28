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
    
    var currentRound: Round!
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
    }
    
    func sendSkeleton() {
        DBManager.pull("Templates", rowKey: "templateType", rowValue: "TeamTemplate", finalKey: "templateJSON", completion: {(result)->Void in
            var teamJSON = result
            DBManager.push(ParseClass.SouthFlorida.rawValue, rowKey: "teamNumber", rowValue: self.teamNumber, finalKey: "TeamInfo", object: teamJSON.dictionaryObject!)
        })
    }
    
    func createRound(roundNum: Int) {
        currentRound = Round(roundNumber: roundNum)
    }
    
    func submitCurrentRound() {
        DBManager.pull(ParseClass.SouthFlorida.rawValue, rowKey: "teamNumber", rowValue: self.teamNumber, finalKey: "TeamInfo", completion: {(result)->Void in
            var teamJSON = result
            teamJSON["rounds"].arrayObject?.append(self.currentRound.getRound()) //appends current round being edited
            DBManager.push(ParseClass.SouthFlorida.rawValue, rowKey: "teamNumber", rowValue: self.teamNumber, finalKey: "TeamInfo", object: teamJSON.dictionaryObject!)
        })
    }
    
    func getAllRounds(completion:(result:[JSON])->Void) {
        DBManager.pull(ParseClass.SouthFlorida.rawValue, rowKey: "teamNumber", rowValue: self.teamNumber, finalKey: "TeamInfo", completion: {(result)->Void in
            var teamJSON = result
            completion(result: teamJSON["rounds"].array!)
        })
        print("No rounds found")
    }
    
    func getAllParticipatingMatches(completion: (result: [JSON]) -> Void) {
        BlueAlliance.sendRequestMatches(CompetitionCode.Javits, completion: {(matches: [JSON]) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                var participatedMatches: [JSON] = []
                for match in matches {
                    if BlueAlliance.getTeamsFromMatch(match, color: "blue").contains(self.teamNumber) {
                        participatedMatches.append(match)
                    }else if BlueAlliance.getTeamsFromMatch(match, color: "red").contains(self.teamNumber){
                        participatedMatches.append(match)
                    }
                }
                completion(result: participatedMatches)
            })
        })
    }
    
    func getAllianceAndEnemyTeamsFromMatch(match: JSON) -> (allianceTeams: [Int], enemyTeams: [Int]) {
        var allianceTeams: [Int] = []
        var enemyTeams: [Int] = []

        if BlueAlliance.getTeamsFromMatch(match, color: "blue").contains(self.teamNumber) {
            for team in BlueAlliance.getTeamsFromMatch(match, color: "blue") {
                if (team != 1155) {
                    allianceTeams.append(team)
                }
            }
            for team in BlueAlliance.getTeamsFromMatch(match, color: "red") {
                enemyTeams.append(team)
            }
        }else if BlueAlliance.getTeamsFromMatch(match, color: "red").contains(self.teamNumber){
            for team in BlueAlliance.getTeamsFromMatch(match, color: "red") {
                if (team != 1155) {
                    allianceTeams.append(team)
                }
            }
            for team in BlueAlliance.getTeamsFromMatch(match, color: "blue") {
                enemyTeams.append(team)
            }
        }
        
        return (allianceTeams, enemyTeams)
    }
}
