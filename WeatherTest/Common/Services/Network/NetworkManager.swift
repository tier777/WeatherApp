//
//  NetworkManager.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

enum NetworkDataError: Error {
    
    case noContentError
    case jsonParsingError
    
    var localizedDescription: String {
        
        switch self {
        case .noContentError: return "No content."
        case .jsonParsingError: return "Response parsing error."
        }
    }
}

protocol NetworkManagerProtocol: AnyObject {
    
    func get(from url: URL, complition: @escaping (Result<Data, Error>) -> Void)
    
    func getJson(from url: URL, complition: @escaping (Result<JSON, Error>) -> Void)
}

class NetworkManager {
    
    private func convertDataToJSON(data: Data?) -> Result<JSON, Error> {
        
        guard let data = data else {
            
            return .failure(NetworkDataError.noContentError)
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data) as? JSON else {
            
            return .failure(NetworkDataError.jsonParsingError)
        }
        
        return .success(json)
    }
    
    private func check(response: URLResponse?) -> Error? {
        
        if let httpResponse = response as? HTTPURLResponse {
            
            return httpResponse.statusCode == 404 ? NetworkDataError.noContentError : nil
        }
        
        return nil
    }
}

extension NetworkManager: NetworkManagerProtocol {
    
    func get(from url: URL, complition: @escaping (Result<Data, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let statusError = self.check(response: response) {
                
                complition(.failure(statusError))
                
                return
            }
            
            guard let data = data, error == nil else {
                
                complition(.failure(error!))
                
                return
            }
            
            complition(.success(data))
            
            }.resume()
    }
    
    func getJson(from url: URL, complition: @escaping (Result<JSON, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let statusError = self.check(response: response) {
                
                complition(.failure(statusError))
                
                return
            }
            
            guard error == nil else {
                
                complition(.failure(error!))
                
                return
            }
            
            switch self.convertDataToJSON(data: data) {
            case .success(let json):
                
                complition(.success(json))
                
            case .failure(let error):
                
                complition(.failure(error))
            }
        }.resume()
    }
}
