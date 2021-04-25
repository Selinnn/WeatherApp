//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Selin KAPLAN on 25.04.2021.
//

import Foundation
import UIKit

struct WeatherViewModel {
    var day: Int
    var img: URL
    var max: String
    var min: String
    
    init(_ weatherModel: WeatherModel) {
        self.day = weatherModel.day
        self.img = URL(string: weatherModel.imgUrl) ?? URL(string: "http://openweathermap.org/img/wn/10d@2x.png")!
        self.max = "\(String(format: "%.0f", (weatherModel.max) - 273.15))°"
        self.min = "\(String(format: "%.0f", (weatherModel.min) - 273.15))°"
    }
    
    
}
