//
//  WeatherService.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

protocol WeatherServiceProtocol: AnyObject {
    
    func getForecastByLocation(latitude: Double, longitude: Double, complition: @escaping (Result<City, Error>) -> Void)
    func getForecastByCity(name: String, complition: @escaping (Result<City, Error>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    
    private let networkManager = NetworkManager()
    
    func getForecastByLocation(latitude: Double, longitude: Double, complition: @escaping (Result<City, Error>) -> Void) {
        
        let url = OpenWeatherAPI.forecastByLocation(latitude: latitude, longitude: longitude).url
        
        networkManager.get(from: url) {
            result in
            
            switch result {
            case .success(let data):
                
                do {
                    
                    complition(.success(try JSONDecoder().decode(City.self, from: data)))
                    
                } catch {
                    
                    complition(.failure(error))
                }
                
            case .failure(let error):
                
                complition(.failure(error))
            }
        }
    }
    
    func getForecastByCity(name: String, complition: @escaping (Result<City, Error>) -> Void) {
        
        let url = OpenWeatherAPI.forecastByCity(name: name).url
        
        networkManager.get(from: url) {
            result in
            
            switch result {
            case .success(let data):
                
                do {
                    
                    complition(.success(try JSONDecoder().decode(City.self, from: data)))
                    
                } catch {
                    
                    complition(.failure(error))
                }
                
            case .failure(let error):
                
                complition(.failure(error))
            }
        }
    }
}
