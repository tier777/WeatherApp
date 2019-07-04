//
//  WeatherListCell.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherListCellViewProtocol: AnyObject {
    
    func display(image: UIImage?)
    func display(city: String?)
    func display(temperature: String?)
}

class WeatherListCell: UITableViewCell {
    
    var presenter: WeatherListCellPresenterProtocol?
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityLabel.font = AppFonts.common
        temperatureLabel.font = AppFonts.common
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        weatherImageView.image = nil
    }
}

extension WeatherListCell: WeatherListCellViewProtocol {
    
    func display(image: UIImage?) {
        
        DispatchQueue.main.async {
            
            self.weatherImageView.image = image
        }
    }
    
    func display(city: String?) {
        
        DispatchQueue.main.async {
            
            self.cityLabel.text = city
        }
    }
    
    func display(temperature: String?) {
        
        DispatchQueue.main.async {
            
            self.temperatureLabel.text = temperature
        }
    }
}
