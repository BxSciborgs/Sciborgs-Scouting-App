//
//  GetTeams.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/20/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import SwiftHTTP

enum CompetitionCode: String{
    case Javits = "nyny"
    case Rochester = "nyro"
}

class GetTeams{
    
    init(){
            
        
    }
    
    static func sendRequestMatches(competitionCode: CompetitionCode,  completion:(matches: Int)->Void){
        do {
            let opt = try HTTP.GET("http://www.thebluealliance.com/api/v2/event/2015\(competitionCode.rawValue)/matches", parameters: ["X-TBA-App-Id": "frc1155:scouting-app:v1"])
            
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
                
                let json = JSON(data: response.data)
                //print(json)
                
//                var i = 0
//                while (i < json.count){
//                    print(json[i]["key"])
//                    i++
//                }
                
                completion(matches: json.count)
                
                //completion(teamNames: allTeamNames, teamNumbers: allTeamNumbers)
            }
        } catch let error {
            print("couldn't serialize the paraemeters: \(error)")
        }
    
    }
    
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
}