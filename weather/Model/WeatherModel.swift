//
//  WeatherModel.swift
//  weather
//
//  Created by Дина Черных on 25.02.23.
//

import Foundation


struct WeatherModel {
    let weatherCode: Int
    let cityName: String
    let tempreture: Double
    
    var tempretureString: String {
        String(format: "%.1f", tempreture)
    }
    var conditionName: String {
        switch weatherCode {
        case 1180...1201, 1240...1280:
            return "cloud.rain"
        case 1204...1237:
            return "snow"
        case 1000:
            return "sun.min"
        case 1003...1009:
            return "cloud"
        case 1030...1071:
            return "wind"
        default:
            return "cloud"
        }
    }
}
