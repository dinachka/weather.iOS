//
//  weatherData.swift
//  weather
//
//  Created by Дина Черных on 25.02.23.
//

import Foundation

struct WeatherData: Codable {
    let location: Location
    let current: Current
}

struct Location: Codable {
    let name: String
    let lat: Double
    let lon: Double
}

struct Condition: Codable {
    let code: Int
}

struct Current: Codable {
    let condition: Condition
    let temp_c: Double
}
