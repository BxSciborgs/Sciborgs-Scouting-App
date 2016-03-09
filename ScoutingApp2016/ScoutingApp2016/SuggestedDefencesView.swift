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
            
            DBManager.pull(ParseClass.TeamsTest.rawValue, rowKey: "teamNumber", rowValue: teams[1],finalKey: "TeamInfo", completion: {(result: JSON) -> Void in
                let teamSummary = TeamSummaryView(allRounds: result["rounds"].arrayValue)
                self.individualAvgValues.append(teamSummary.keyLabelsDictionary)
                self.totalRounds =  self.totalRounds + Double(result["rounds"].arrayValue.count)
                
                DBManager.pull(ParseClass.TeamsTest.rawValue, rowKey: "teamNumber", rowValue: teams[2],finalKey: "TeamInfo", completion: {(result: JSON) -> Void in
                    let teamSummary = TeamSummaryView(allRounds: result["rounds"].arrayValue)
                    self.individualAvgValues.append(teamSummary.keyLabelsDictionary)
                    self.totalRounds =  self.totalRounds + Double(result["rounds"].arrayValue.count)
                    
                    if(self.individualAvgValues.count == 3) {
                        self.calculateAverageValues()
                    }
                })
            })
        })
    
        
    }
    
    func calculateAverageValues() {
        for i in 0..<avgLabels.count {
            
            var value: Double = 0
            var appearances = 0
            
            for j in 0..<2 {
                if((individualAvgValues[j][avgLabels[i]]!.doubleValue)! != -1) {
                    value += (individualAvgValues[j][avgLabels[i]]?.doubleValue)!
                    appearances++
                }
            }

            if(appearances > 0) {
                totalAvgValues[avgLabels[i]] = value
            }else {
                totalAvgValues[avgLabels[i]] = -1
            }
        }
        
        print("Average Values \(totalAvgValues)")
        print(getWorstFourDefenses())
    }
    
    func getWorstFourDefenses() -> [String] {
        
        var values = [Double]()
        var worstDefenses = [String]()
        
        for i in 0..<avgLabels.count {
            let value: Double = self.totalAvgValues[avgLabels[i]]!.doubleValue
            values.append(value)
        }
        
        func sortFunc(num1: Int, num2: Int) -> Bool {
            return num1 < num2
        }

        let sortedValues = values.sort {
            return $0 < $1

        }
        
        for i in 0..<sortedValues.count {
            if(self.totalAvgValues[avgLabels[i]]!.doubleValue == sortedValues[i]) {
                worstDefenses.append(avgLabels[i])
            }
        }
        
        return worstDefenses
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}