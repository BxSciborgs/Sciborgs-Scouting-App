//
//  SuggestedDefencesView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 3/7/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation

class SuggestedDefencesView: UIView {
    
    var individualAvgValues: [[String: AnyObject]]!
    
    var totalRounds: Double! = 0
    
    var avgKeys: [String] = []
    var avgLabels: [String] = []
    
    var totalAvgValues: [String: AnyObject] = [:]
    
    init(teams: [Int]) {
        super.init(frame:
            CGRectMake(
                Screen.width, 0,
                Screen.width, Screen.height
            )
        )
        
        print("Teams \(teams)")
    
        avgLabels = [
            "Crossed Portcullis: ",
            "Crossed ChevalDeFrise: ",
            "Crossed Moat: ",
            "Crossed Ramparts: ",
            "Crossed Drawbridge: ",
            "Crossed SallyPort: ",
            "Crossed RockWall: ",
            "Crossed RoughTerrain: ",
            "Crossed LowBar: "
        ]
        
        for i in 0..<2 {
            DBManager.pull(ParseClass.TeamsTest.rawValue, rowKey: "teamNumber", rowValue: teams[i], finalKey: "TeamInfo", completion: {(result: JSON) -> Void in
                let teamSummary = TeamSummaryView(allRounds: result["rounds"].arrayValue)
                self.individualAvgValues[i] = teamSummary.keyLabelsDictionary
                self.totalRounds =  self.totalRounds + teamSummary.numberOfRounds
                
                if(i == 2) {
                    self.calculateAverageValues()
                }
            })
        }
    }
    
    func calculateAverageValues() {
        for i in 0..<avgLabels.count {
            var avgValue: Double = 0
            
            for j in 0..<2 {
                avgValue = avgValue + (individualAvgValues[j][avgLabels[i]]?.doubleValue)!
            }
            
            avgValue = avgValue/self.totalRounds
            totalAvgValues[avgLabels[i]] = avgValue
        }
        print("Average Values \(totalAvgValues)")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}