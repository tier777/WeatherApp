//
//  AddCityAlertController.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol AddCityAlertControllerProtocol: AnyObject {
    
    var delegate: AddCityAlertControllerDelegate? { get set }
}

protocol AddCityAlertControllerDelegate: AnyObject {
    
    func addButtonTapped(fieldInput: String?)
}

class AddCityAlertController: UIAlertController, AddCityAlertControllerProtocol {
    
    weak var delegate: AddCityAlertControllerDelegate?
}
