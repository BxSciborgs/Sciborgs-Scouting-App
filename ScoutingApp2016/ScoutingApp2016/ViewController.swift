//
//  ViewController.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/13/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit
//import GoogleSignIn/GoogleSignIn.h

public struct Screen{
    static let width = UIScreen.mainScreen().bounds.width
    static let height = UIScreen.mainScreen().bounds.height
}

class ViewController: UIViewController, GIDSignInUIDelegate {

    var button: GIDSignInButton!
    var pickMode: PickModeView!
    var testTeamProfile: TeamProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        button = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        button.center = CGPoint(x: Screen.width/2, y: Screen.height/2)
        button.enabled = true
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        pickMode = PickModeView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        view.addSubview(button)
        //view.addSubview(pickMode)
        
        //Creates a TeamRound to store data for a SPECIFIC ROUND
        let testTeam = Team(teamNumber: 1155)
        
        //Information for testTeam round 1
        //testTeam.crossedDefence(Defences.ChevalDeFrise) //example defence data
        //testTeam.crossedDefence(Defences.Portcullis) //example defence data
        //testTeam.addComment("ThisIsRound3") //example comment
        //testTeam.finalizeJSON()
        
        //creates a TeamProfile to store data for ALL ROUNDS
        //testTeamProfile = TeamProfile(teamNumber: 1155)
        //testTeamProfile.queryAllRounds()//gets data from Parse
        //print("arr: " + String(testTeamProfile.getJSONS())) //returns array full of JSON objects
        //print("done")

    }
    
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        
    }
    
    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        
    }
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        view.addSubview(pickMode)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

