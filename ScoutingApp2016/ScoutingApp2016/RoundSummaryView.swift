//
//  RoundSummaryView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 3/7/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation

class RoundSummaryView: UIView, UIScrollViewDelegate{
    
    init(teamAssignmentView: TeamAssignmentView, enemyTeams: [Int]) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addBackButton()
        
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
        scrollView.delegate = self
        scrollView.directionalLockEnabled = true
        scrollView.pagingEnabled = true
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.Black
        scrollView.contentSize = CGSize(width: self.frame.width * 2, height: self.frame.height-bsConstants.svh)
        scrollView.alpha = 1
        
        scrollView.addSubview(teamAssignmentView)
        scrollView.addSubview(SuggestedDefencesView(teams: enemyTeams))
        self.addSubview(scrollView)
    }
    
    func back() {
        self.goBack()
        ///self.removeNavBar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}