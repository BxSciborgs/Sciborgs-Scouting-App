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
    
    var currentRound: JSON!
    
    init(teamNumber: Int!) {
        self.teamNumber = teamNumber
        
    }
}
