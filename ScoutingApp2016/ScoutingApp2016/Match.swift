//
//  Match.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation

class Match {
    
    var teams: [Team]
    var matchNum: Int!
    
    init(matchNum: Int!, teams: [Team]) {
        self.teams = teams
        self.matchNum = matchNum
    }
    
    func getTeams() -> [Team] {
        return teams
    }
    
    func getMatchNum() -> Int {
        return matchNum
    }
    
}