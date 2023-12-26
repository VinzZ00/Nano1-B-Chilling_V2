//
//  CoreLocationManager.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 25/12/23.
//

import Foundation
import CoreLocation

protocol locationUpdateProtocol {
    func updateLocation(clLocation : CLLocation) -> Void
}

class LocationManagerService : NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var locationCallBack : locationUpdateProtocol
    
    init(locationCallBack: locationUpdateProtocol) {
        self.locationCallBack = locationCallBack
    }
    
    func setupLocationManager() {
        if locationManager.authorizationStatus !=  .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            locationCallBack.updateLocation(clLocation: loc)
        }
    }
}
