//
//  WeatherListCell.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherListCellViewProtocol {
    
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
}

extension WeatherListCell: WeatherListCellViewProtocol {
    
    func display(image: UIImage?) {
        
        weatherImageView.image = image
    }
    
    func display(city: String?) {
        
        cityLabel.text = city
    }
    
    func display(temperature: String?) {
        
        temperatureLabel.text = temperature
    }
}
