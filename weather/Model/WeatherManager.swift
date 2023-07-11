//
//  weatherManager.swift
//  weather
//
//  Created by Дина Черных on 25.02.23.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    
    func didFailWithError(error: Error)

}


struct WeatherManager {
    var delegate: WeatherManagerDelegate?
    let weatherURL = "https://api.weatherapi.com/v1/current.json?key=8ba570af9de8468cb51101431232502"
    
    func fetchWeatherData(city: String) {
        let urlString = weatherURL + "&q=\(city)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = weatherURL + "&q=\(latitude),\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                      self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather =  self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        do {
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: weatherData)
            let code = decodedData.current.condition.code
            let temp = decodedData.current.temp_c
            let city = decodedData.location.name
            let weather = WeatherModel(weatherCode: code, cityName: city, tempreture: temp)
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
