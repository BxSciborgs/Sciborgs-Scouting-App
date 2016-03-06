//
//  TeamProfileView.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/26/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class TeamProfileView: UIView, UIScrollViewDelegate{
    
    var teamNumber: Int!
    var currentTeamProfile: Team!
    
    var teamJSON: JSON!
    var allRounds: [JSON]!
    
    var teamNumberLabel: BasicLabel!
    
    var scrollView: UIScrollView!
    
    init(teamNumber: Int, json: JSON) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.backgroundColor = UIColor.whiteColor()
        self.teamNumber = teamNumber
        
        self.addBackButton()

        currentTeamProfile = Team(teamNumber: self.teamNumber)
        
        teamJSON = json
        allRounds = teamJSON["rounds"].arrayValue
        
        teamNumberLabel = BasicLabel(
            frame: self.frame,
            text: "\(teamNumber)",
            fontSize: 80,
            color: UIColor.whiteColor(),
            position: CGPoint(
                x: Screen.width/2,
                y: Screen.height/12
            )
        )
        let colorView = UIView(frame: CGRectMake(0, Screen.height/12, Screen.width, Screen.height/11.7))
        colorView.backgroundColor = UIColor(red: 1, green: 0.93, blue: 0.09, alpha: 1)
        
        //OFFSET SCROLLVIEW
        
        scrollView = UIScrollView(frame: CGRectMake(0, bsConstants.svh, self.frame.width, self.frame.height))
        scrollView.delegate = self
        scrollView.directionalLockEnabled = true
        scrollView.pagingEnabled = true
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.Black
        scrollView.contentSize = CGSize(width: self.frame.width * 2, height: self.frame.height-bsConstants.svh)
        scrollView.alpha = 1
                
        let teamSummaryView = TeamSummaryView()
        let teamSummaryRoundView = TeamSummaryRoundView(rounds: allRounds)
        
        scrollView.addSubview(teamSummaryView)
        scrollView.addSubview(teamSummaryRoundView)
        
        self.addSubview(colorView)
        self.addSubview(teamNumberLabel)
        self.addSubview(scrollView)
    }
    
    func back(){
        self.goBack()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
