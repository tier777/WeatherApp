//
//  UserDefaultsManager.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 04/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    
    static var shared: UserDefaultsManagerProtocol { get }
}

class UserDefaultsManager {
    
    enum Keys {
        
        static let cities = "cities"
    }
    
    private init() {}
    
    static let shared: UserDefaultsManagerProtocol = UserDefaultsManager()
    
    private var defaults: UserDefaults {
        
        return UserDefaults.standard
    }
}

extension UserDefaultsManager: UserDefaultsManagerProtocol {
    
    
}
