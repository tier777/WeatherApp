//
//  WindDirections.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

enum WindDirections {
    
    case northerly
    case northWesterly
    case westerly
    case southWesterly
    case southerly
    case southEasterly
    case easterly
    case northEasterly
    
    init(windDegrees: Float) {
        
        switch windDegrees {
        case let degrees where degrees > 337.5: self = .northerly
        case let degrees where degrees > 292.5: self = .northWesterly
        case let degrees where degrees > 247.5: self = .westerly
        case let degrees where degrees > 202.5: self = .southWesterly
        case let degrees where degrees > 157.5: self = .southerly
        case let degrees where degrees > 122.5: self = .southEasterly
        case let degrees where degrees > 67.5: self = .easterly
        case let degrees where degrees > 22.5: self = .northEasterly
        default: self = .northerly
        }
    }
    
    var title: String {
        
        switch self {
        case .northerly: return "Northerly"
        case .northWesterly: return "North Westerly"
        case .westerly: return "Westerly"
        case .southWesterly: return "South Westerly"
        case .southerly: return "Southerly"
        case .southEasterly: return "South Easterly"
        case .easterly: return "Easterly"
        case .northEasterly: return "North Easterly"
        }
    }
    
    var abbreviation: String {
        
        let divided = title.components(separatedBy: " ")
        let firstLetters: [String] = divided.compactMap { String($0.first ?? Character("")).capitalized }
        
        return firstLetters.joined()
    }
}
