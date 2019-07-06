//
//  Wind.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

struct Wind {
    
    let speed: Float?
    let direction: Float?
}

extension Wind: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case speed = "speed"
        case direction = "deg"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        speed = try container.decodeIfPresent(Float.self, forKey: .speed)
        direction = try container.decodeIfPresent(Float.self, forKey: .direction)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(speed, forKey: .speed)
        try container.encode(direction, forKey: .direction)
    }
}
