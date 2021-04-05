//
//  WeatherManager.swift
//  WatchWeather WatchKit Extension
//
//  Created by benjamiin on 30/03/2021.
//

import Foundation

class WeatherManager: ObservableObject {
    @Published var weatherModel = WeatherModel(lat: 0, lon: 0, timezone: "Amsterdam", timezoneOffset: 0, current: Current(dt: 0, sunrise: 0, sunset: 0, temp: 0, feelsLike: 0, pressure: 0, humidity: 0, dewPoint: 0, uvi: 0, clouds: 0, visibility: 0, windSpeed: 0, windDeg: 0, windGust: 0, rain: Current.OneHour(oneHour: 0), snow: Current.OneHour(oneHour: 0), weather: [], pop: 0), minutely: [], hourly: [], alerts: [])
    
    let apiKey = "4b3ab421eec8ff1a3dd622d82f1225d6"
    
    func getWeather(for coord: WeatherCoordinates) {
//        let url = URL(string: "https://api.lil.software/weather?latitude=\(coord.lat)&longitude=\(coord.lon)&localityLanguage=en")!
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(coord.lat)&lon=\(coord.lon)&exclude=hourly,daily&units=metric&appid=\(apiKey)")!
        
        print(url)
        
        NetworkManager<WeatherModel>().fetch(for: url) { result in
            switch result {
            case .failure(let err):
                switch err {
                case .badResponse:
                    print("Bad response: \(err.localizedDescription)")
                case .decodingError(let error):
                    print("Decoding error: \(error)")
                case .emptyData:
                    print("Empty Data: \(err.localizedDescription)")
                case .error(let error):
                    print("Error: \(error)")
                case .wrongStatusCode(let code):
                    print("Wrong Status Code: \(code)")
                }
            case .success(let res):
                self.weatherModel = res
            }
        }
    }
}
