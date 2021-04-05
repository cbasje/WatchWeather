//
//  LocationManager.swift
//  WatchWeather WatchKit Extension
//
//  Created by benjamiin on 30/03/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var cityName = "San Fransisco"
    @Published var coordinate = CLLocationCoordinate2D(latitude: 37.231, longitude: -122.2322)
    
    private var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        coordinate = location.coordinate
        
        getCity(for: location.coordinate)
    }
    
    func getCity(for coord: CLLocationCoordinate2D) {
        let url = URL(string: "https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=\(coord.latitude)&longitude=\(coord.longitude)")!
        
        NetworkManager<CityModel>().fetch(for: url) { result in
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let res):
                self.cityName = "\(res.city), \(res.countryCode)"
            }
        }
    }
}
