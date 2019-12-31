//
//  AppliancesServiceManager.swift
//  Zouba
//
//  Created by Vinoth Varatharajan on 25/09/19.
//  Copyright © 2019 Vin. All rights reserved.
//

import Foundation

enum DashboardServiceManager {
    
    case mockDashboard(_ scope : String)
    
    var scheme: String {
        switch self {
        case .mockDashboard : return API.scheme
        }
    }
    
    var host: String {
        switch self {
        case .mockDashboard: return API.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .mockDashboard: return "/v10/analytic/dashboard/operation/mock"
        }
    }
    
    var method: String {
        switch self {
        case .mockDashboard: return "GET"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .mockDashboard(let scope):
            return [URLQueryItem(name: "scope", value: scope.replacingOccurrences(of: " ", with: "_"))]
        }
    }
    
    var headerFields: [String : String] {
        switch self
        {
        case .mockDashboard: return [:]
        }
    }
    
    var body: Data? {
        switch self {
        case .mockDashboard:
            return nil
        }
    }
    
    var formDataParameters : [String : Any]? {
        switch self {
        case .mockDashboard:return nil
        }
    }
}



