//
//  Match.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation

class Round {
    
    var teams: [TeamRound]
    var matchNum: Int!
    
    init(matchNum: Int!, teams: [TeamRound]) {
        self.teams = teams
        self.matchNum = matchNum
    }
    
    func getTeams() -> [TeamRound] {
        return teams
    }
    
    func getMatchNum() -> Int {
        return matchNum
    }
    
}