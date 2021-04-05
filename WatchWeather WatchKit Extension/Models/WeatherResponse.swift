//
//  WeatherResponse.swift
//  WatchWeather WatchKit Extension
//
//  Created by benjamiin on 30/03/2021.
//

import Foundation

struct WeatherResponse: Codable {
    var forecast: [WeatherModel]
}
