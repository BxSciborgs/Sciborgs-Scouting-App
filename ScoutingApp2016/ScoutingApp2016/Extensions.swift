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


public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}


