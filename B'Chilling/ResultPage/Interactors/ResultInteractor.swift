//
//  ResultPageInteractor.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 28/12/23.
//

import Foundation
import CoreLocation

protocol ResultInteractorProtocol : AnyObject {
    var presenter : ResultPresenterProtocol? {get set}
    var userCurrentLocation : CLLocation? {get set}
    var destination : Destination? {get set}
    var placeDetail : PlaceDetail? {get set}
    var locationManager : LocationManagerServiceProtocol {get set}
    
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

class ResultInteractor : ResultInteractorProtocol {
    
    var locationManager: LocationManagerServiceProtocol = LocationManagerService.shared
    
    weak var presenter: ResultPresenterProtocol?
    var userCurrentLocation: CLLocation?
    var destination : Destination?
    var placeDetail : PlaceDetail?
    
    func startUpdatingLocation() {
        locationManager.locationCallBack = self
        locationManager.startLocationUpdate()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopLocationUpdate()
    }
    
}

extension ResultInteractor : locationUpdateProtocol {

    func updateLocation(clLocation: CLLocation) {
        self.userCurrentLocation = clLocation
    }
    
    
}
