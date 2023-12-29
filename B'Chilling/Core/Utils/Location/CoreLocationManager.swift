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

protocol LocationManagerServiceProtocol {
    static var shared : LocationManagerService {get}
    var locationCallBack : locationUpdateProtocol? {get set}
    func setupLocationManager()
    func startLocationUpdate()
    func stopLocationUpdate()
}

class LocationManagerService : NSObject, CLLocationManagerDelegate, LocationManagerServiceProtocol {
    private let locationManager = CLLocationManager()
    var locationCallBack : locationUpdateProtocol?
    
    static var shared : LocationManagerService = LocationManagerService()
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        if locationManager.authorizationStatus != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    func startLocationUpdate() {
        locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdate() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last,
           let locationCallBack = locationCallBack 
        {
            locationCallBack.updateLocation(clLocation: loc)
        }
    }
}
