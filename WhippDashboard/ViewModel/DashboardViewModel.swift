//
//  DashboardViewModel.swift
//  WhippDashboard
//
//  Created by Vinoth Varatharajan on 30/12/2019.
//  Copyright © 2019 Vin. All rights reserved.
//

import Foundation

protocol DashboardViewModelDelegate {
    func getResponseSuccessfull(_ analytics : Analytics)
    func getResponseFailure()
}

class DashboardViewModel {
    
    var delegate : DashboardViewModelDelegate?
    
    func getMockData( scope : String) {
        
        DashboardServiceHelper.request(router: .mockDashboard(scope), completion: { (result : Result<MockResponse, CustomError>) in

            DispatchQueue.main.async {
                switch result {
                case .success(let mockResponse): self.delegate?.getResponseSuccessfull(mockResponse.response.data.analytics)
                case .failure: self.delegate?.getResponseFailure()
                }
            }
        })
    }
}
