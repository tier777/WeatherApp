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
    
    func display(image: UIImage?)
    func display(city: String?)
    func display(temperature: String?)
}

class WeatherDetailsViewController: UIViewController {
    
    var presenter: WeatherDetailsPresenterProtocol?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windDirectionView: WindDirectionView!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windDirectionTitleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        presenter?.closeButtonTapped()
    }
}

extension WeatherDetailsViewController: WeatherDetailsViewProtocol {
    
    func display(city: String?) {
        
        DispatchQueue.main.async {
            
            self.cityLabel.text = city
        }
    }
    
    func display(image: UIImage?) {
        
        DispatchQueue.main.async {
            
            self.weatherImageView.image = image
        }
    }
    
    func display(temperature: String?) {
        
        DispatchQueue.main.async {
            
            self.temperatureLabel.text = temperature
        }
    }
}

class WindDirectionView: UIView {
    
    //TODO: it later
}
