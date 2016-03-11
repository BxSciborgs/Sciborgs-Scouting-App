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
    var totalAvgValues: [String: AnyObject] = [:]
    
    var worstValues: [Double]! = []
    var worstNames: [String]! = []

    var totalRounds: Double! = 0
    
    var avgLabels: [String] = []
    
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
                        self.postCompletionMethod()
                    }
                })
            })
        })
        
    }
    
    func postCompletionMethod() {
        self.worstValues = self.getWorstFourDefenses().values
        self.worstNames = self.getWorstFourDefenses().names
        
        self.worstValues.removeAtIndex(self.worstNames.indexOf("LowBar:")!)
        self.worstNames.removeAtIndex(self.worstNames.indexOf("LowBar:")!)
        
        print(self.worstValues)
        print(self.worstNames)
        
        let teamNumberLabel = BasicLabel(
            frame: self.frame,
            text: "Suggestions",
            fontSize: 50,
            color: UIColor.darkGrayColor(),
            position: CGPoint(
                x: Screen.width/2,
                y: Screen.height/12
            )
        )
        
        self.addSubview(teamNumberLabel)
        
        for i in 0..<worstNames.count {
            let yPos = CGFloat(((2+(Double(1)*Double(i)))/10))
            let labelName = BasicLabel(
                frame: self.frame,
                text: worstNames[i],
                fontSize: 30,
                color: UIColor.darkGrayColor(),
                position: CGPoint(
                    x: 2/5*self.frame.width,
                    y: yPos*self.frame.height
                )
            )
            let labelKey = BasicLabel(
                frame: self.frame,
                text: "\(worstValues[i])",
                fontSize: 30,
                color: UIColor.darkGrayColor(),
                position: CGPoint(
                    x: (self.frame.width/2) + 1.15/5*self.frame.width,
                    y: yPos*self.frame.height
                )
            )
            self.addSubview(labelName)
            self.addSubview(labelKey)
        }
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
    }
    
    func getWorstFourDefenses() -> (values: [Double], names: [String]) {
        calculateAverageValues()
        
        var values = [Double]()
        
        var worstValues = [Double]()
        var worstNames = [String]()
        
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
            if(sortedValues[i] != -1) {
                for j in 0..<avgLabels.count {
                    if(self.totalAvgValues[avgLabels[j]]!.doubleValue == sortedValues[i]) {
                        worstValues.append(self.totalAvgValues[avgLabels[j]]!.doubleValue)
                        worstNames.append(avgLabels[j].substring(8, end: avgLabels[j].characters.count-1))
                    }
                }
            }else {
                if(self.totalAvgValues[avgLabels[i]]!.doubleValue == sortedValues[i]) {
                    worstValues.append(self.totalAvgValues[avgLabels[i]]!.doubleValue)
                    worstNames.append(avgLabels[i].substring(8, end: avgLabels[i].characters.count-1))
                }
            }
        }
        
        return (worstValues, worstNames)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}