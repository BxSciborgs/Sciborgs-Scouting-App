//
//  SuggestedDefencesView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 3/7/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation

class SuggestedDefencesView: UIView {
    
    var individualAvgValues: [[String: AnyObject]]! = [[:]]
    
    var totalRounds: Double! = 0
    
    var avgKeys: [String] = []
    var avgLabels: [String] = []
    
    var totalAvgValues: [String: AnyObject] = [:]
    
    var calculatedAverages: Bool! = false
    
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
        
    
        DBManager.pull(ParseClass.TeamsTest.rawValue, rowKey: "teamNumber", rowValue: teams[0],finalKey: "TeamInfo", completion: {(result: JSON) -> Void in
            let teamSummary = TeamSummaryView(allRounds: result["rounds"].arrayValue)
            self.individualAvgValues[0] = (teamSummary.keyLabelsDictionary)
            self.totalRounds =  self.totalRounds + Double(result["rounds"].arrayValue.count)
            
            if(self.individualAvgValues.count == 3) {
                self.calculateAverageValues()
            }
        })
        
        DBManager.pull(ParseClass.TeamsTest.rawValue, rowKey: "teamNumber", rowValue: teams[1],finalKey: "TeamInfo", completion: {(result: JSON) -> Void in
            let teamSummary = TeamSummaryView(allRounds: result["rounds"].arrayValue)
            self.individualAvgValues.append(teamSummary.keyLabelsDictionary)
            self.totalRounds =  self.totalRounds + Double(result["rounds"].arrayValue.count)

            if(self.individualAvgValues.count == 3) {
                self.calculateAverageValues()
            }
        })
        
        DBManager.pull(ParseClass.TeamsTest.rawValue, rowKey: "teamNumber", rowValue: teams[2],finalKey: "TeamInfo", completion: {(result: JSON) -> Void in
            let teamSummary = TeamSummaryView(allRounds: result["rounds"].arrayValue)
            self.individualAvgValues.append(teamSummary.keyLabelsDictionary)
            self.totalRounds =  self.totalRounds + Double(result["rounds"].arrayValue.count)
            
            if(self.individualAvgValues.count == 3) {
                self.calculateAverageValues()
            }
        })
        
    }
    
    func calculateAverageValues() {
        print(self.totalRounds)
        calculatedAverages = true
        for i in 0..<avgLabels.count {
            var avgValue: Double = 0
            
            for j in 0..<2 {
                avgValue = avgValue + (individualAvgValues[j][avgLabels[i]]?.doubleValue)!
            }
            
            avgValue = avgValue/self.totalRounds
            totalAvgValues[avgLabels[i]] = avgValue
        }
        print("Average Values \(totalAvgValues)")
        
        print(getWorstThreeDefenses())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}