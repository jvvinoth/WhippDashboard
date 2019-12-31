//
//  DictionaryExtension.swift
//  Customer
//
//  Created by Vinoth Varatharajan on 23/11/17.
//  Copyright © 2017 Vin. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /**
     Convenience Initializers to initialize storyboard.
     
     - parameter storyboard: String of storyboard name
     - parameter bundle:     NSBundle object
     
     - returns: A Storyboard object
     */
    convenience init(storyboard: String, bundle: Bundle? = nil) {
        self.init(name: storyboard, bundle: bundle)
    }
    
    /**
     Initiate view controller with view controller name.
     
     - returns: A UIView controller object
     */
    func instantiateViewController<T: UIViewController>() -> T {
        var fullName: String = NSStringFromClass(T.self)
        if let range = fullName.range(of: ".", options: .backwards) {
            fullName = String(fullName[range.upperBound...])
        }
        
        guard let viewController = self.instantiateViewController(withIdentifier: fullName) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(fullName) ")
        }
        
        return viewController
    }
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    class func dashboardStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "DashBoard", bundle: nil)
    }
    
    class func applicationsStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Applications", bundle: nil)
    }
    
    class func onBoardingStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "OnBoarding", bundle: nil)
    }
    
    class func termsandConditionStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Terms&Condition", bundle: nil)
    }
    
    class func popUpStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Popup", bundle: nil)
    }
}

extension Dictionary {
    
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}

extension NSDictionary {
    
    func containsObject(key : String) -> Bool {
        if (self.allKeys as NSArray).contains(key) {
            return true
        }
        else {
            return false
        }
    }
    
    func hasKey() -> Bool {
        return self.allKeys.count > 0 ? true : false
    }
}
