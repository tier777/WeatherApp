//
//  Temperature.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 04/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

struct Temperature {
    
    let temperature: Float?
}

extension Temperature: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case temperature = "temp"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try container.decodeIfPresent(Float.self, forKey: .temperature)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(temperature, forKey: .temperature)
    }
}
