//
//  Match.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import Parse
import Bolts

class Round {
    
    var roundNumber: Int!
    var template: JSON!
    
    init(roundNumber: Int!) {
        print("Round\(roundNumber) created")
        self.roundNumber = roundNumber
        
        DBManager.pull("Templates", rowKey: "templateType", rowValue: "RoundTemplate", finalKey: "templateJSON", completion: {(result: JSON)->Void in
            self.template = result
            print(self.template)
            print("Got round template")
            
            self.template!["roundNumber"].int = roundNumber
        })
    }
    
    func crossedDefense(defenseName: String) { // Will be changed eventually depending on how buttons works
        template!["telePoints"]["defenses"]["numTimesCrossed\(defenseName)"].int = template!["telePoints"]["defenses"]["numTimesCrossed\(defenseName)"].int! + 1
    }
    
    func updateAutoInfo(autoName: String, value: Bool) { //Will also change depending on how buttons works
        template![autoName].bool = value
    }
    
    func gotGoal(goal: String) {
        template!["telePoints"]["goals"][goal].int = template!["telePoints"]["goals"][goal].int! + 1
    }
    
    func canScale(canScale: Bool!) {
        template!["telePoints"]["scaling"].bool = canScale
    }
    
    func finalScore(score: Int) {
        template!["finalScore"].int = score
    }
    
    func addComment(comment: String) {
        template!["comments"].string = comment
    }
    
    func getRound() -> [String: AnyObject] {
        return template!.dictionaryObject!
    }
    
}