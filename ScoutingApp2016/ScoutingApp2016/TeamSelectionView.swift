//
//  TeamSelectionView.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class TeamSelectionView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    var title: BasicLabel!
    var tableView: UITableView!
    var cells: [UITableViewCell!]!
    var teamNamesArray: [String]!
    var teamNumbersArray: [Int]!
    var searchbar: UITextField!
    
    var tap: UITapGestureRecognizer?
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.backgroundColor = UIColor.whiteColor()
        
        // Premade code that adds a back button and calls  a "back" method
        self.addBackButton()
        
        cells = []
        
        title = BasicLabel(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height), text: "TEAMS", fontSize: 60, color: UIColor.darkGrayColor(), position: CGPoint(x: Screen.width/2, y: Screen.height/14))
    
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height*0.6), style: UITableViewStyle.Plain)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        let ourTeamsButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor.lightGrayColor(), size: CGRect(x: 0, y: 0, width: frame.width/1.5, height: frame.width/4.5), location: CGPoint(x: frame.width/2,y: 0.9*frame.height/4), title: "OUR ROUNDS", titleSize: 50)
        ourTeamsButton.addTarget(self, action: "openOurTeams", forControlEvents: UIControlEvents.TouchUpInside)

        self.addSubview(ourTeamsButton)
        
        //Create list of teams
        BlueAlliance.sendRequestTeams(CompetitionCode.Javits, completion: {(teamNames: [String], teamNumbers: [Int]) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.teamNumbersArray = teamNumbers
                self.teamNamesArray = teamNames
                for x in 0..<teamNumbers.count{
                    self.makeCell(teamNames[x], number: teamNumbers[x])
                }
                self.tableView.reloadData()
            })
        })
        
        
        //Adding the search bar
        searchbar = UITextField(
            frame: CGRect(
                x: Screen.width/20,
                y:  1.20*frame.height/4,
                width: Screen.width - Screen.width/4,
                height: 44
            )
        )
        
        var searchButton = BasicButton(
            type: UIButtonType.RoundedRect,
            color: UIColor.lightGrayColor(),
            size: CGRect(
                x: Screen.width - Screen.width/20,
                y: 1.15*frame.height/4,
                width: Screen.width/5,
                height: Screen.height/20),
            location: CGPoint(
                x: Screen.width - Screen.width/9,
                y: 1.35*frame.height/4
            ),
            title: "SEARCH",
            titleSize: 14
        )
        
        searchButton.addTarget(self, action: "searchForTeam", forControlEvents: UIControlEvents.TouchUpInside)
        
        searchbar.placeholder = "Search by name or number"
        searchbar.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardLaunched",
            name: UIKeyboardDidShowNotification,
            object: nil
        )
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardClosed",
            name: UIKeyboardDidHideNotification,
            object: nil
        )
        
        searchbar.keyboardType = UIKeyboardType.Default
        
        searchbar.delegate = self
        
        self.addSubview(searchbar)
        self.addSubview(searchButton)
        
        // centering the table view
        tableView.center = CGPoint(x: Screen.width/2, y: Screen.height/2 + Screen.height/5.7)

        //adding them
        
        self.addSubview(title)
        self.addSubview(tableView)
    }
    
    func addAllTeams(){
        //Create list of teams
        BlueAlliance.sendRequestTeams(CompetitionCode.Javits, completion: {(teamNames: [String], teamNumbers: [Int]) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.teamNumbersArray = teamNumbers
                self.teamNamesArray = teamNames
                for x in 0..<teamNumbers.count{
                    self.makeCell(teamNames[x], number: teamNumbers[x])
                }
                self.tableView.reloadData()
            })
        })
    }
    
    func keyboardLaunched(){
        tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.addGestureRecognizer(tap!)
    }
    
    func keyboardClosed(){
        self.removeGestureRecognizer(tap!)
    }
    
    func clearTableView(){
        cells = []
        
        tableView.reloadData()
    }
    
    
    // Search method
    func searchForTeam(){
        
        self.dismissKeyboard()
        
        if (searchbar.text! == ""){
            
            //print(UIKeyboardDidShowNotification)
            
            clearTableView()
            
            addAllTeams()
            
            return
        }
        
        clearTableView()
        
        var searchResultName: [String] = []
        var searchResultNumber: [Int] = []
        
        //teamNamesArray = []
        //teamNumbersArray = []
        
        //print(teamNamesArray)
        
        //Create list of teams
        BlueAlliance.sendRequestTeams(CompetitionCode.Javits, completion: {(teamNames: [String], teamNumbers: [Int]) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.teamNumbersArray = teamNumbers
                self.teamNamesArray = teamNames
                //self.tableView.beginUpdates()
                for x in 0..<teamNumbers.count{
                    
                    if ((self.teamNamesArray[x].containsString(self.searchbar.text!) || String(self.teamNumbersArray[x]).containsString(self.searchbar.text!)) && self.searchbar.text! != ""){
                        //print("found \(teamNames[x])")
                        searchResultName.append(teamNames[x])
                        searchResultNumber.append(teamNumbers[x])
                        //self.makeCell(teamNames[x], number: teamNumbers[x])
                    }
                    
                }
                
                
                // Sorting in the correct order
                // TODO
                
                if (searchResultName.count == 0){
                    self.makeCell("No SouthFlorida Found", number: 0)
                }
        
                
                // Adding the cells
                
                self.cells = []
                self.teamNumbersArray = []
                self.teamNamesArray = []
                
                for i in 0..<searchResultName.count{
                    self.teamNamesArray.append(searchResultName[i])
                    self.teamNumbersArray.append(searchResultNumber[i])
                    self.makeCell(searchResultName[i], number: searchResultNumber[i])
                }
                
                //self.tableView.endUpdates()
                self.tableView.reloadData()
            })
        })
        
        // centering the table view
        tableView.center = CGPoint(x: Screen.width/2, y: Screen.height/2 + Screen.height/5.7)
        
        tableView.reloadData()
        self.addSubview(tableView)
        tableView.reloadData()
        
        print(teamNamesArray.indexOf(searchbar.text!))
        
    }
    
    
    // Dismises the keyboard
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status
        self.endEditing(true)
    }
    
    // DW ABOUT IT I WAS DESPERATE
    func makeEmptyCell(){
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/8))
        
        cells.append(cell)
        tableView.insertSubview(cell, atIndex: cells.count - 1)
    }
    
    // Creates a cell for the tableview
    func makeCell(name: String , number: Int){
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/8))
        let nameText = UILabel(frame: cell.frame)
        
        let maxLength = 30
        
        //checks to make sure the name isnt too long
        if (name.characters.count >= maxLength){
            nameText.text = name.substring(0, end: maxLength-3) + "..."
        } else{
            nameText.text = name
        }
        
        nameText.textAlignment = NSTextAlignment.Left
        nameText.center = CGPoint(x: nameText.center.x + Screen.width * 0.05, y: nameText.center.y)
        
        let numberText = UILabel(frame: cell.frame)
        numberText.text = String(number)
        numberText.textAlignment = NSTextAlignment.Center
        
        if(UIDevice.currentDevice().modelName == "iPhone 5s" || UIDevice.currentDevice().modelName == "iPhone 5c" || UIDevice.currentDevice().modelName == "iPhone 5" || UIDevice.currentDevice().modelName == "iPhone 4") {
            numberText.center = CGPoint(x: numberText.center.x + (Screen.width/2.5), y: numberText.center.y)
        }else if (UIDevice.currentDevice().modelName == "iPhone 6" || UIDevice.currentDevice().modelName == "iPhone 6s"){
            numberText.center = CGPoint(x: numberText.center.x + (Screen.width/2.1), y: numberText.center.y)
        }else if (UIDevice.currentDevice().modelName == "iPhone 6 Plus" || UIDevice.currentDevice().modelName == "iPhone 6s Plus") {
            numberText.center = CGPoint(x: numberText.center.x + (Screen.width/1.8), y: numberText.center.y)
        }else if (UIDevice.currentDevice().modelName == "iPad 2" || UIDevice.currentDevice().modelName == "iPad 3" || UIDevice.currentDevice().modelName == "iPad 4" || UIDevice.currentDevice().modelName == "iPad Air" || UIDevice.currentDevice().modelName == "iPad Air 2") {
            numberText.center = CGPoint(x: numberText.center.x + (Screen.width/2.7), y: numberText.center.y)
        }else if (UIDevice.currentDevice().modelName.containsString("iPad")) {
            numberText.center = CGPoint(x: numberText.center.x + (Screen.width/2.7), y: numberText.center.y)
        }
        else {
            numberText.center = CGPoint(x: numberText.center.x + (Screen.width/2.1), y: numberText.center.y)
        }
        
        cell.contentView.addSubview(nameText)
        cell.contentView.addSubview(numberText)
        cells.append(cell)
        
        tableView.insertSubview(cell, atIndex: cells.count - 1)
    }
    
    func back(){
        self.goBack()
        self.removeNavBar()
    }
    
    func openOurTeams() {
        self.dismissKeyboard()
        self.launchViewOnTop(OurRoundsView())
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Team\(teamNumbersArray[indexPath.row])")
        
        //self.dismissKeyboard()
        //self.launchViewOnTop(cells[indexPath.row])
        
        DBManager.pull(ParseClass.SouthFlorida.rawValue, rowKey: "teamNumber", rowValue: teamNumbersArray[indexPath.row], finalKey: "TeamInfo", completion: {(result: JSON) -> Void in
            
            
            
            self.dismissKeyboard()
            self.launchViewOnTop(TeamProfileView(teamNumber: self.teamNumbersArray[indexPath.row], json: result))
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return cells[indexPath.row]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITableViewCell{
    
}
