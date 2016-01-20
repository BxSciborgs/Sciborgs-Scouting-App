//
//  GetTeams.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/20/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import SwiftHTTP

class GetTeams{
    
    var allTeamsNumbers: [Int]!
    var allTeamNames: [String]!
    
    init(){
            
        do {
            let opt = try HTTP.GET("http://www.thebluealliance.com/api/v2/event/2016nyny/teams", parameters: ["X-TBA-App-Id": "frc1155:scouting-app:v1"])//, headers: ["header": "value"])
            opt.start { response in
                //do stuff
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                print("Request Recieved")
                
                self.allTeamNames = []
                self.allTeamsNumbers = []
                
                let json = JSON(data: response.data)
                var tempJSON: JSON
                var i = 0
                while(i < json.count){
                    tempJSON = json[i]
                    self.allTeamNames.append(String(tempJSON["nickname"]))
                    self.allTeamsNumbers.append(Int(String(tempJSON["team_number"]))!)
                    i++
                }
            }
        } catch let error {
            print("couldn't serialize the paraemeters: \(error)")
        }
    }
    
    func getTeamNumbers() -> [Int]{
        return allTeamsNumbers
    }
    
    func getTeamNames() -> [String]{
        return allTeamNames
    }
}