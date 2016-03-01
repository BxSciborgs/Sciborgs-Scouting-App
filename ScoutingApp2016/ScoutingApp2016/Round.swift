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
            print("Got round template")
            
            self.template!["roundNumber"].int = roundNumber
        })
    }
    
    func getRound() -> [String: AnyObject] {
        return template!.dictionaryObject!
    }
    
}