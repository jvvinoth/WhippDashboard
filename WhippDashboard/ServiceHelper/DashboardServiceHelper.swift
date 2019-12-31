//
//  OnBoardingServiceHelper.swift
//  Zouba
//
//  Created by Vinoth Varatharajan on 24/09/19.
//  Copyright © 2019 Vin. All rights reserved.
//

import Foundation
import UIKit

enum CustomError : Error {
    case message(String)
    case unKnown
    case offline(String)
}

class DashboardServiceHelper {
    
    class func request<T: Codable>(router: DashboardServiceManager, completion: @escaping (Result<T, CustomError>) -> ()) {
        
        let window = UIApplication.shared.windows.first
        
        if !ReachabilityManager.isConnectedToNetwork() {
            completion(.failure(.offline("Please Check Your Internet Connection")))
            return
        }
        
        MBProgressHUD.showAdded(to: window!, animated: true)
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return }
        
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        ServiceHelper.instance.request(forUrlRequest: urlRequest, completion: { (result : Result<Data, CustomError>) in
            
            DispatchQueue.main.async {
                
                MBProgressHUD.hide(for: window!, animated: true)
                
                switch result {
                case .success(let data):
                    
                    do {
                        if let dict = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String : Any] {
                            
                            print(dict)
                            
                            if let status = dict["httpStatus"] as? Int,status == StatusCode.created.rawValue
                            {
                                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                                    completion(.success(responseObject))
                                }
                                else {
                                    completion(.failure(.unKnown))
                                }
                            }
                            else if let message = dict["message"] as? String {
                                completion(.failure(.message(message)))
                            }
                            else {
                                completion(.failure(.unKnown))
                            }
                        }
                        else {
                            completion(.failure(.unKnown))
                        }
                    }
                    catch (let error) {
                        completion(.failure(.message(error.localizedDescription)))
                    }
                    
                case .failure(let message): completion(.failure(message))
                }
            }
        })
    }
}
