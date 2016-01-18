//
//  JSONMaker.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/17/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation

class JSONMaker {
    
    var jsonObject: [String: AnyObject]
    var jsonString: String!
    
    init(str: String){
        jsonString = str
        jsonObject = ["": ""]
    }
    
    func make() ->[String: AnyObject]{
        
        let start = CFAbsoluteTimeGetCurrent()
        var i = 0
        
        //print("jsonString", jsonString)
        
        var keyArray: [String] = []
        var valueArray: [String] = []
        
        var x = ""
        var a = ""
        var y = false
        var z = false
        
        while (i < jsonString.characters.count){
            let letter = jsonString.substring(i, end: i+1)
            
            if (letter == ":"){
                y = false
            }
            else if (letter == ","){
                z = false
            }
            
            if (y){
                x = x + letter
            }
            if (z){
                a = a + letter
            }
            
            if (letter == "{"){
                y = true
            }
            else if(letter == ":"){
                z = true
            }
            else if (letter == "," || letter == "}"){
                y = true

                x.trim()
                keyArray.append(x)
                x = ""
                
                a.trim()
                valueArray.append(a)
                a = ""
            }
            
            i++
        }
        
        
        for index in 0..<keyArray.count{
            jsonObject[keyArray[index]] = valueArray[index]
        }
        
        
        let end = CFAbsoluteTimeGetCurrent()
        
        print("Took", String(end - start), "seconds to make JSON")
        return jsonObject
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




