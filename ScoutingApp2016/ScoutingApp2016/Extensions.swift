//
//  Extentions.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

extension String{
    // Substring method where you can put in int values as opposed to indecies
    // (for some reason indicies are a different type thing)
    // mainly for debugging purposes
    func substring(start: Int,end: Int) -> String{
        return self.substringWithRange(self.startIndex.advancedBy(start)..<self.startIndex.advancedBy(end))
    }
    
//    func indexRange(start: Int, end: Int) -> Range<Index>{
//        return self.startIndex.advancedBy(start)..<self.startIndex.advancedBy(end)
//    }
    
    mutating func trim(){
        let trimLetters: [Character] = [" ", "\n", "\t", "\"", "}"]
        
        for ltr in characters{
            if (trimLetters.contains(ltr)){
                removeAtIndex(characters.indexOf(ltr)!)
            }
        }
    }
    
    mutating func trim(char: Character){
        for ltr in characters{
            if (ltr == char){
                removeAtIndex(characters.indexOf(ltr)!)
            }
        }
    }
    
    // Counts the appearances of a string in another
    func countRepetitions(substring: String) -> Int{
        var repetitions = 0
        var newString = self
        
        if (substring.endIndex > self.endIndex || self.rangeOfString(substring) == nil){
            return 0
        }
        
        // creates a new string after the index of the substring in the original string
        while(newString.rangeOfString(substring) != nil){
            repetitions += 1
            newString = newString.substringWithRange((newString.rangeOfString(substring)?.endIndex)!..<newString.endIndex)
        }
        
        return repetitions
    }
}

extension UIView{
    func addBackButton(){
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Done, target: self, action: "back")
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = nil
        
        // Assign the navigation item to the navigation bar
        (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.items = [navigationItem]
        (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.setItems([navigationItem], animated: false)
    }
    
    // Doesnt remove the current View
    func launchViewOnTop(view: UIView){
        //(UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.setItems(nil, animated: false)
        //(UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.items = nil
        
        UIApplication.sharedApplication().keyWindow?.rootViewController!.view.insertSubview(view, belowSubview: (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar)
        //view.addBackButton()
    }
    
    func goBack(){
        UIApplication.sharedApplication().keyWindow?.rootViewController?.view.subviews[(UIApplication.sharedApplication().keyWindow?.rootViewController?.view.subviews.count)!-3].addBackButton()
        self.removeFromSuperview()
    }
    
    func removeNavBar(){
        (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.setItems(nil, animated: false)
    }
    
    func launchView(view: UIView){
        //(UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.items = nil
       UIApplication.sharedApplication().keyWindow?.rootViewController!.view.insertSubview(view, belowSubview: (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar)
        self.removeFromSuperview()
    }
    
    private struct AssociatedKeys {
        static var DescriptiveName = "nsh_DescriptiveName"
    }
    
    var name: String! {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName)! as! String
        }
        set (newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue as NSString?,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


