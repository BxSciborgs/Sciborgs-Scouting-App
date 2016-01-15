//
//  ViewController.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/13/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit
//import GoogleSignIn/GoogleSignIn.h

class ViewController: UIViewController, GIDSignInUIDelegate {

    var button: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()     
        
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        button = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        button.center = CGPoint(x: width/2, y: height/2)
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        button.enabled = true
        
        view.addSubview(button)
        print("done")
        
        let testTeam = Team(teamNumber: 1155, roundNumber: 1)
        
        //Information for testTeam round 1
        testTeam.crossedDefence(Defences.SallyPort)
        testTeam.crossedDefence(Defences.Drawbridge)
        testTeam.addComment("ThisTeamIsAmazing")
        //testTeam.finalizeJSON()
        
        let testTeamProfile = TeamProfile(teamNumber: 1155)
        testTeamProfile.queryAllRounds()
    }
    
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        
    }
    
    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        
    }
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

