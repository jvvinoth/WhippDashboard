//
//  ServiceHelper.swift
//  Zouba
//
//  Created by Vinoth Varatharajan on 25/09/19.
//  Copyright © 2019 Vin. All rights reserved.
//

import Foundation
import UIKit

enum StatusCode : Int {
    case success = 200
    case created = 201
    case unAuthorized = 401
    case refreshTokenFailure = 400
}

class ServiceHelper : NSObject {
    
    static let instance = ServiceHelper()
    let window = UIApplication.shared.windows.first
    
    func requestFormData(withData data : Data, forRequest request : URLRequest, completion: @escaping (Result<Data, CustomError>) -> ()) {
          
        loadDataSession(forData: data, withURLRequest: request, completionHandler: {
            data, response, error in
            self.processResponse(urlRequest: request, data: data, response: response, error: error, completion: completion)
        })
    }
    
    func request(forUrlRequest urlRequest : URLRequest, completion: @escaping (Result<Data, CustomError>) -> ()) {
    
        loadURLSession(withURLRequest: urlRequest, completionHandler: {
            data, response, error in
            self.processResponse(urlRequest: urlRequest, data: data, response: response, error: error, completion: completion)
        })
    }
    
    private func loadURLSession(withURLRequest request : URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, response, error in
            completionHandler(data,response,error)
        }
        
        dataTask.resume()
    }
    
    private func loadDataSession(forData data : Data, withURLRequest request : URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.uploadTask(with: request, from: data, completionHandler: { data, response, error in
            completionHandler(data,response,error)
        }).resume()
    }
    
    private func processResponse(urlRequest : URLRequest, data : Data?, response : URLResponse?, error : Error?, completion : @escaping (Result<Data, CustomError>) -> ()) {
        
        guard error == nil else {
            completion(.failure(.message(error!.localizedDescription)))
            if let errorDesc = error?.localizedDescription {
                print(errorDesc)
            }
            return
        }
        
        guard response != nil else {
            completion(.failure(.unKnown))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, let statusCode = StatusCode(rawValue: httpResponse.statusCode) else {
            completion(.failure(.unKnown))
            return
        }
        
        switch statusCode {
            
        case .success,.created:
            
            guard let _data = data else {
                completion(.failure(.unKnown))
                return
            }
            
            completion(.success(_data))
            
        case .unAuthorized,.refreshTokenFailure: break
        }
    }
}
