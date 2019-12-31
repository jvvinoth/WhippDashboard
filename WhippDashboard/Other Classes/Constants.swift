//
//  Constants.swift
//  iJob
//
//  Created by Vinoth Varatharajan on 10/01/18.
//  Copyright © 2018 Vin. All rights reserved.
//

import UIKit

struct REGEX {
    static let phone_indian = "^(?:(?:\\+|0{0,2})91(\\s*[\\-]\\s*)?|[0]?)?[789]\\d{9}$"
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let phone_aus = "([(0),(+61)][23478]){0,1}[1-9][0-9]{7}"
    
}

struct AppFontName {
    static let regular = "GothamBook"
    static let bold = "GothamBold"
    static let italic = "GothamMedium"
}

enum GrantType : String {
    case password = "password"
    case refreshToken = "refresh_token"
}

struct ColorWheel {
    let colorsArray = [
        UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0), //teal color
        UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), //yellow color
        UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0), //red color
        UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0), //orange color
        UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0), //dark color
        UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0), //purple color
        UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0), //green color
    ]
}

struct API {
    
    static let baseURL = "skyrim.whipmobility.io"
    static let scheme = "http"
}

extension API {
    
    static var fullBaseUrl : String {
        get {
            return API.scheme + "://" + API.baseURL
        }
    }
}

struct GOOGLE {
    static let placesAPI_KEY = "AIzaSyBqOCrPjA9IXTn8pHiNozi6cWI91oIetG0"
}

struct DEVICE {
    static let deviceType       = "2"
    static let deviceName       = UIDevice.current.name
    static let deviceModel      = UIDevice.current.model
    static let systemVersion    = UIDevice.current.systemVersion
    static let appVersion       = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    static let buildNo          = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "100"
}
