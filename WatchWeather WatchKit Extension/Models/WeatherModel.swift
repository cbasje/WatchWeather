//
//  WeatherModel.swift
//  WatchWeather WatchKit Extension
//
//  Created by benjamiin on 30/03/2021.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    var lat, lon: Double
    var timezone: String
    var timezoneOffset: Int
    var current: Current
    var minutely: [Minutely]
    var hourly: [Current]?
    var alerts: [Alert]?

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, alerts
    }
}

// MARK: - Current
struct Current: Codable {
    var dt, sunrise, sunset: Int
    var temp, feelsLike: Double
    var pressure, humidity: Int
    var dewPoint, uvi: Double
    var clouds, visibility: Int
    var windSpeed: Double
    var windDeg: Int
    var windGust: Double?
    var rain: OneHour?
    var snow: OneHour?
    var weather: [Weather]
    var pop: Double?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case rain, snow, pop, weather
    }
    
    struct OneHour: Codable {
        var oneHour: Int
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
        }
    }
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int
    var main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    var conditions: String {
        switch weatherDescription {
        case let str where str.lowercased().contains("clear"):
            return "sun.max.fill"
        case let str where str.lowercased().contains("rain"):
            return "cloud.rain.fill"
        case let str where str.lowercased().contains("sunny"):
            return "sun.max.fill"
        case let str where str.lowercased().contains("cloudy"):
            return "cloud.fill"
        case let str where str.lowercased().contains("snow"):
            return "cloud.snow.fill"
        case let str where str.lowercased().contains("fog"):
            return "cloud.fog.fill"
        case let str where str.lowercased().contains("storm"):
            return "tropicalstorm"
        default:
            return "sun.max"
        }
    }
}

// MARK: - Minutely
struct Minutely: Codable {
    var dt, precipitation: Int
}

// MARK: - Alert
struct Alert: Codable {
    var senderName, event: String
    var start, end: Int
    var alertDescription: String

    enum CodingKeys: String, CodingKey {
        case senderName = "sender_name"
        case event, start, end
        case alertDescription = "description"
    }
}
