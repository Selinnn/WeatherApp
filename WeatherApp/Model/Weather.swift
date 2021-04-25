//
//  Weather.swift
//  WeatherApp
//
//  Created by Selin KAPLAN on 23.04.2021.
//

import Foundation

struct Weather: Decodable {
    var timezone: String
    var current: Current
    var daily: [DailyWeather]
}

struct Current: Decodable {
    var temp: Double
    var weather: [CurrentWeather]
}

struct CurrentWeather: Decodable {
    var icon: String
    var description: String
}

struct DailyWeather: Decodable {
    var dt: Int
    var temp: DailyTemp
    var weather: [CurrentWeather]
}

struct DailyTemp: Decodable {
    var day: Double
    var min: Double
    var max: Double
}
