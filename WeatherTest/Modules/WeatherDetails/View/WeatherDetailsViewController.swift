//
//  WeatherDetailsViewController.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherDetailsViewProtocol: AnyObject {
    
    var presenter: WeatherDetailsPresenterProtocol? { get set }
}

class WeatherDetailsViewController: UIViewController {
    
    var presenter: WeatherDetailsPresenterProtocol?
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension WeatherDetailsViewController: WeatherDetailsViewProtocol {
    
    
}
