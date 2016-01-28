//
//  ScoutView.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class ScoutView: UIView{
    
    init(teamNumber: Int){
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.backgroundColor = UIColor.whiteColor()
        
        print("view created for team " + String(teamNumber))
        
        self.addBackButton()
    }

    func back(){
        
        removeFromSuperview()
        //self.lauchView(TeamPickerView(blueTeams: <#T##[Int]#>, redTeams: <#T##[Int]#>))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}