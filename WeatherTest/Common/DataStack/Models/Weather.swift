//
//  Weather.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 04/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

struct Weather {
    
    let iconId: String?
}

extension Weather: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case iconId = "icon"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iconId = try container.decodeIfPresent(String.self, forKey: .iconId)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(iconId, forKey: .iconId)
    }
}
