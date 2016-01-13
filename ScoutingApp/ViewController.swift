//
//  ViewController.swift
//  ScoutingApp
//
//  Created by Oran Luzon on 1/12/16.
//  Copyright © 2016 Oran Luzon. All rights reserved.
//
//For the scouting section, you need to be able to store the following information, and try to keep it as quantitative as possible in order to remove bias.  This is not the only info, and it is up to you as to how to ask it.  Please add more as you need necessary:

//- For each obstacle, can they cross it, and how well (scale 1-10?), as well as how many times did they cross it?
//- How many shots did they get in low goal
//- How many shots did they get in high goal
//- Can they scale?
//- Low or high robot?
//
//We need a way to have a captain version of the app (have people login using their bxscience email account) where I can assign people on certain days for certain rounds and robots.  Then their app needs to remind them when they are, show them their schedule, and take in the info.  Matt will show you how to save the info to the database once he figures it out.
//
//Finally, on my side before every match it needs to be able to show me two screens, one with the robots we are going against, and one with the robots we are playing with.  It needs to show their strengths, and recommend obstacles that we should choose.
//
//Try to make it look nice and be user-friendly.  Write up your plan on a google doc, and share it with sciborgs@bxscience.edu.

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ramparts: Obstacle = Obstacle(name: "Ramparts", image: UIImage(named: "Defense")!)
        
        self.view.addSubview(ramparts)
        print("done")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}















