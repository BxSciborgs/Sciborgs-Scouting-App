//
//  BlueAlliance.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/20/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import SwiftHTTP

enum CompetitionCode: String {
    case Javits = "nyny"
    case Rochester = "nyro"
}

// Made for fetching information from TheBlueAlliance
class BlueAlliance{
    static func sendRequestMatches(competitionCode: CompetitionCode,  completion:(matches: [JSON])->Void){
        do {
            let opt = try HTTP.GET("http://www.thebluealliance.com/api/v2/event/2015\(competitionCode.rawValue)/matches", parameters: ["X-TBA-App-Id": "frc1155:scouting-app:v1"])
            
            opt.start { response in
                if let err = response.error {
                    if (err.localizedDescription == "The Internet connection appears to be offline."){
                        print("No Wifi")
                        return
                    }
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                print("Request Recieved")
                
                let matchesJSON: JSON = JSON(data: response.data)
                var matches: [JSON] = []
                
                for i in 0..<matchesJSON.count {
                    if (matchesJSON[i]["comp_level"] == "qm") {
                        matches.append(matchesJSON[i])
                    }
                }
                
                func compareMatchNum(m1: JSON, _ m2: JSON) -> Bool {
                    return m1["match_number"] < m2["match_number"]
                }
                
                matches.sortInPlace(compareMatchNum)
                
                completion(matches: matches)
            }
        } catch let error {
            print("couldn't serialize the paraemeters: \(error)")
        }
    }
    
//    static func getMatch(competitionCode: CompetitionCode, match: Int!, completion:(match: JSON)->Void){
//        do {
//            let opt = try HTTP.GET("http://www.thebluealliance.com/api/v2/event/2015\(competitionCode.rawValue)/matches", parameters: ["X-TBA-App-Id": "frc1155:scouting-app:v1"])
//            
//            opt.start { response in
//                if let err = response.error {
//                    if (err.localizedDescription == "The Internet connection appears to be offline."){
//                        print("No Wifi")
//                        return
//                    }
//                    print("error: \(err.localizedDescription)")
//                    return //also notify app of failure as needed
//                }
//                
//                print("Request Recieved")
//                
//                let json = JSON(data: response.data)
//                completion(match: json[match-1])
//            }
//        } catch let error {
//            print("couldn't serialize the paraemeters: \(error)")
//        }
//    }
    
    static func sendRequestTeams(competitionCode: CompetitionCode, completion:(teamNames: [String], teamNumbers: [Int])->Void){
        var allTeamNumbers: [Int]!
        var allTeamNames: [String]!
        
        do {
            let opt = try HTTP.GET("http://www.thebluealliance.com/api/v2/event/2015\(competitionCode.rawValue)/teams", parameters: ["X-TBA-App-Id": "frc1155:scouting-app:v1"])
            
            opt.start { response in
                //do stuff
                //DO THIS A BETTER WAY
                if let err = response.error {
                    if (err.localizedDescription == "The Internet connection appears to be offline."){
                        print("No Wifi")
                        return
                    }
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                print("Request Recieved")
                
                allTeamNames = []
                allTeamNumbers = []
                
                let json = JSON(data: response.data)
                //print(json)
                var tempJSON: JSON
                var i = 0
                while(i < json.count){
                    tempJSON = json[i]
                    allTeamNames.append(String(tempJSON["nickname"]))
                    allTeamNumbers.append(Int(String(tempJSON["team_number"]))!)
                    i++
                }
                
                completion(teamNames: allTeamNames, teamNumbers: allTeamNumbers)
            }
        } catch let error {
            print("couldn't serialize the paraemeters: \(error)")
        }
    }
    
    static func getTeamsFromMatch(match: JSON, color: String) -> [Int] {
        let teamArray = match["alliances"][color]["teams"].array
        
        var teamNumbers: [Int] = []
        for team in teamArray! {
            var teamNumber: String = String(team)
            teamNumber = teamNumber.stringByReplacingOccurrencesOfString("frc", withString: "")
            teamNumbers.append(Int(teamNumber)!)
        }
        return teamNumbers
    }
}