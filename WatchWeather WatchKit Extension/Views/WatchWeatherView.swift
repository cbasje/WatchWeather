//
//  WatchWeatherView.swift
//  WatchWeather WatchKit Extension
//
//  Created by benjamiin on 30/03/2021.
//

import SwiftUI

struct WatchWeatherView: View {
    @ObservedObject private var locationManager = LocationManager()
    @ObservedObject private var weatherManager = WeatherManager()
    
    var format: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        return formatter
    }
    
    var body: some View {
        ZStack {
            OutlineView()
            
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Text(locationManager.cityName)
                        .lineLimit(1)
                        .minimumScaleFactor(0.005)
                    
                    Image(systemName: "paperplane.fill")
                        .font(.caption)
                }
                
                if let today = weatherManager.weatherModel {
                    if let weather = today.current.weather.first {
                        Image(systemName: weather.conditions)
                            .renderingMode(.original)
                            .font(.title)
                        
                        Text(today.current.weather[0].weatherDescription)
                            .font(.footnote)
                            .lineLimit(1)
    //                        .minimumScaleFactor(0.005)
                            .foregroundColor(.gray)
                    }
                    
                    Text("\(Measurement(value: today.current.temp, unit: UnitTemperature.celsius), formatter: format)")
//                    Text("\(today.current.temp, specifier: "%0.0f") °F")
                        .bold()
                        .font(.title)
                }
            }
            .shadow(color: Color.white.opacity(0.2), radius: 2, x: -2, y: -2)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
        }
        .onReceive(locationManager.$cityName, perform: { _ in
            weatherManager.getWeather(for: WeatherCoordinates(lat: locationManager.coordinate.latitude, lon: locationManager.coordinate.longitude))
        })
    }
}

struct WatchWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WatchWeatherView()
        
        Image(systemName: "sun.max.fill")
            .renderingMode(.original)
    }
}
