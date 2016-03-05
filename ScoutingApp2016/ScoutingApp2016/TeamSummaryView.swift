//
//  TeamSummaryView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 3/5/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation

class TeamSummaryView: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))

        let summaryLabel = BasicLabel(
            frame: Screen.frame,
            text: "Summary",
            fontSize: 50,
            color: UIColor.darkGrayColor(),
            position: CGPoint(
                x: Screen.width/2,
                y: 0
            )
        )
        
        self.addSubview(summaryLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}