//
//  Team.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import Parse
import Bolts

public enum Defences {
    case Portcullis
    case ChevalDeFrise
    case Moat
    case Ramparts
    case Drawbridge
    case SallyPort
    case RockWall
    case RoughtTerrain
    case LowBar
}

//Information for a SPECIFIC ROUND
class TeamRound {
    
    var teamNumber: Int?
    var roundNumber: Int?
    
    var jsonObject: [String: AnyObject]
    
    //scouting info for defences
    var numTimesCrossedPortcullis: Int = 0
    var numTimesCrossedChevalDeFrise: Int = 0
    var numTimesCrossedMoat: Int = 0
    var numTimesCrossedRamparts: Int = 0
    var numTimesCrossedDrawbridge: Int = 0
    var numTimesCrossedSallyPort: Int = 0
    var numTimesCrossedRockWall: Int = 0
    var numTimesCrossedRoughTerrain: Int = 0
    var numTimesCrossedLowBar: Int = 0
    
    //scouting comment
    var comment: String?
    
    var pfObject: PFObject?
    
    init(teamNumber: Int!, roundNumber: Int!) {
        self.teamNumber = teamNumber
        self.roundNumber = roundNumber
        
        //gives the JSON object initial values - these won't change
        jsonObject = ["teamNumber": self.teamNumber!]
        
        comment = ""
        
        pfObject = PFObject(className: "Teams")
    }
    
    //changes the number of times a defence has been crossed
    func crossedDefence(defence: Defences) {
        switch(defence) {
        case Defences.Portcullis:
            numTimesCrossedPortcullis++
            break
        case Defences.ChevalDeFrise:
            numTimesCrossedChevalDeFrise++
            break
        case Defences.Moat:
            numTimesCrossedMoat++
            break
        case Defences.Ramparts:
            numTimesCrossedRamparts++
            break
        case Defences.Drawbridge:
            numTimesCrossedDrawbridge++
            break
        case Defences.SallyPort:
            numTimesCrossedSallyPort++
            break
        case Defences.RockWall:
            numTimesCrossedRockWall++
            break
        case Defences.RoughtTerrain:
            numTimesCrossedRoughTerrain++
            break
        case Defences.LowBar:
            numTimesCrossedLowBar++
            break
        }
    }
    
    //changes comment
    func addComment(comment: String!) {
        self.comment = comment
    }
    
    //finalizes the JSON by setting all the values and keys and sends it up to Parse
    func finalizeJSON() {
        
        jsonObject["crossedPortcullis"] = self.numTimesCrossedPortcullis
        jsonObject["crossedChevalDeFrise"] = self.numTimesCrossedChevalDeFrise
        jsonObject["crossedMoat"] = self.numTimesCrossedMoat
        jsonObject["crossedRamparts"] = self.numTimesCrossedRamparts
        jsonObject["crossedDrawbridge"] = self.numTimesCrossedDrawbridge
        jsonObject["crossedSallyPort"] = self.numTimesCrossedSallyPort
        jsonObject["crossedRockWall"] = self.numTimesCrossedRockWall
        jsonObject["crossedRoughTerrain"] = self.numTimesCrossedRoughTerrain
        jsonObject["crossedLowBar"] = self.numTimesCrossedLowBar
        
        jsonObject["Comment"] = self.comment
                
        var dictionaryJSON: [String: AnyObject] = [:]
        var stringJSON = ""
        let teamQuery = PFQuery(className: "Teams")
        teamQuery.whereKeyExists("Team\(teamNumber!)")
        
        teamQuery.getFirstObjectInBackgroundWithBlock {(team: PFObject?, error: NSError?) -> Void in
            if error == nil {
                let team = team!.objectForKey("Team\(self.teamNumber!)") //info retrieved from databse
                let teamJSON = JSON(team!) //info converted to JSON
                
                var jsonString: String = String(teamJSON)
                jsonString.trim("[")
                jsonString.trim("]")
                
                dictionaryJSON = self.convertStringToDictionary(jsonString)!
                dictionaryJSON["Round\(self.roundNumber!)"] = self.jsonObject
                stringJSON = String(dictionaryJSON)
                stringJSON.trim("[")
                stringJSON.trim("]")
                stringJSON = "[{\(String(stringJSON))}]"
                print(stringJSON)
            } else {
                
            }
        }
        
        //checks if data stored is in valid JSON format
        let valid = NSJSONSerialization.isValidJSONObject(jsonObject)
        if(valid) {
            pfObject!.addObject(stringJSON, forKey: "Team\(teamNumber!)")
            pfObject!.saveInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
                if(succeeded) {
                    print("Sent JSON")
                }else {
                    print("Didnt send: \(error?.description)")
                }
            }
        }

    }
    
    //methods not used, but may be useful in the future
    func getPFObject() -> PFObject {
        return pfObject!
    }
    
    func resetData() {
        numTimesCrossedPortcullis = 0
        numTimesCrossedChevalDeFrise = 0
        numTimesCrossedMoat = 0
        numTimesCrossedRamparts = 0
        numTimesCrossedDrawbridge = 0
        numTimesCrossedSallyPort = 0
        numTimesCrossedRockWall = 0
        numTimesCrossedRoughTerrain = 0
        numTimesCrossedLowBar = 0
        
        comment = ""
        roundNumber = 0
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}
















