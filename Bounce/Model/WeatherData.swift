//
//  WeatherData.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-11-12.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: Array<Weather>
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
