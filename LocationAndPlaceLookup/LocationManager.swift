// File: LocationManager.swift Project: LocationAndPlaceLookup
// Created by: Prof. John Gallaugher on 11/27/24
// YouTube.com/profgallaugher  -  threads.net/john.gallaugher

import Foundation
import MapKit

@Observable

class LocationManager: NSObject, CLLocationManagerDelegate {
    // *** CRITICALLY IMPORTANT *** Always add info.plist message for Privacy - Location When in Use Usage Description
    
    var location: CLLocation?
    private let locationManager = CLLocationManager()
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var errorMessage: String?
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// Delegate methods that Apple has created & will call, but that we filled out
extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return } // Use the last location as the location
        location = newLocation
        
        // You can uncomment this when you only want to get the location once, not repeatedly
        // manager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("LocationManager authorization granted.")
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location manager authorization denied.")
            errorMessage = "😡📍 LocationManager accessed denied"
            manager.stopUpdatingLocation()
        case .notDetermined:
            print("LocationManager authorization not determined")
            manager.requestWhenInUseAuthorization()
        @unknown default:
            print("LOOK FOR NEW eNum for CLLocationManager.authorizationStatus!")
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        errorMessage = error.localizedDescription
        print("😡🗺️ ERROR LocationManager: \(errorMessage ?? "n/a")")
    }
}
