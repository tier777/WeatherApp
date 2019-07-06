//
//  AddCityRouter.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol AddCityRouterProtocol: AnyObject {
    
    static func buildAddCityModule(delegate: AddCityAlertControllerDelegate?) -> UIAlertController
}

class AddCityRouter: AddCityRouterProtocol {
    
    static func buildAddCityModule(delegate: AddCityAlertControllerDelegate?) -> UIAlertController {
        
        let alertController = AddCityAlertController(title: "Add new city", message: "Please, write city here", preferredStyle: .alert)
        alertController.delegate = delegate
        alertController.addTextField {
            
            $0.placeholder = "City"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: {
            [weak alertController] action in
            
            alertController?.delegate?.addButtonTapped(fieldInput: alertController?.textFields?.first?.text)
        }))
        
        return alertController
    }
}
