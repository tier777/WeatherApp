//
//  OpenWeatherAPI.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

private protocol APIProtocol {
    
    static var APIKey: String { get }
    static var basePath: String { get }
    static var version: String { get }
}

private protocol APIItemProtocol {
    
    var path: String { get }
    var url: URL { get }
}

enum OpenWeatherAPI: APIProtocol, APIItemProtocol {
    
    static var APIKey = "521a5dd76a9e57367ecd9137fb7b4f29"
    static var basePath = "https://api.openweathermap.org/data/"
    static var version = "2.5/"
    
    case forecastByLocation(latitude: Double, longitude: Double)
    case forecastByCity(name: String)
    
    var path: String {
        
        switch self {
        case .forecastByLocation(let latitude, let longitude):
            
            return "weather?lat=\(latitude)&lon=\(longitude)"
            
        case .forecastByCity(let name):
            
            return "weather?q=\(name)"
        }
    }
    
    var url: URL {
        
        return URL(string: OpenWeatherAPI.basePath + OpenWeatherAPI.version + path + "&APPID=\(OpenWeatherAPI.APIKey)")!
    }
}
