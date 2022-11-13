//
//  WeatherModel.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-11-12.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.0f", self.temperature)
    }
    
    var condition: String {
        switch self.conditionID {
        case 200...232:
            return "🌩"
        case 300...321:
            return "🌧"
        case 500...531:
            return "🌧"
        case 600...622:
            return "🌨"
        case 701...781:
            return "☁️"
        case 800:
            return "☀️"
        case 801...804:
            return "🌥"
        default:
            return "☁️"
        }
    }
    
}

