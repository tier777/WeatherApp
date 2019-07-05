//
//  City.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 04/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

struct City {
    
    let id : Int?
    let name : String?
    var isCurrent: Bool = false
    var weather: [Weather] = []
    let temperature: Temperature?
    let wind: Wind?
}

extension City: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case isCurrent = "isCurrent"
        case weather = "weather"
        case temperature = "main"
        case wind = "wind"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        isCurrent = try container.decodeIfPresent(Bool.self, forKey: .isCurrent) ?? false
        weather = try container.decodeIfPresent([Weather].self, forKey: .weather) ?? []
        temperature = try container.decodeIfPresent(Temperature.self, forKey: .temperature)
        wind = try container.decodeIfPresent(Wind.self, forKey: .wind)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(isCurrent, forKey: .isCurrent)
        try container.encode(weather, forKey: .weather)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(wind, forKey: .wind)
    }
}
