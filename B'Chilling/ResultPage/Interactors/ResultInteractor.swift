//
//  ResultPageInteractor.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 28/12/23.
//

import Foundation
import CoreLocation
import MapKit

protocol ResultInteractorProtocol : AnyObject {
    var presenter : (ResultPresenterProtocol & InteractorOutputProtocol)? {get set}
    var userCurrentLocation : CLLocation? {get set}
    var destination : Destination? {get set}
    var placeDetail : PlaceDetail? {get set}
    var locationManager : LocationManagerServiceProtocol {get set}
    var polyline : MKPolyline? {get set}
    var routes : [String]? { get set }
    
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func createDirection()
}

class ResultInteractor : ResultInteractorProtocol {
    
    var locationManager: LocationManagerServiceProtocol = LocationManagerService.shared
    
    weak var presenter: (ResultPresenterProtocol & InteractorOutputProtocol)?
    var userCurrentLocation: CLLocation?
    var destination : Destination?
    var placeDetail : PlaceDetail?
    var polyline : MKPolyline?
    var routes : [String]?
    
    func startUpdatingLocation() {
        locationManager.locationCallBack = self
        locationManager.startLocationUpdate()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopLocationUpdate()
    }
    
    func createDirection() {
        let req = MKDirections.Request()
        var direction : MKDirections
        if let userCurrentLocation = userCurrentLocation,
           let destination = destination {
            req.source = MKMapItem(placemark: MKPlacemark(coordinate: userCurrentLocation.coordinate))
            req.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination.FinalSpot.1.coordinate))
            req.transportType = .walking
            direction = MKDirections(request: req)
            direction.calculate { [unowned self] resp, err in
                if err != nil {
                    print("error \(err?.localizedDescription)")
                    return
                }
                
                self.polyline = resp?.routes.first?.polyline
                self.routes = resp?.routes.first?.steps.map{ $0.instructions }
                
                createPlaceDetail()
                presenter?.didCreateDirection()
            }
        }
    }
    
    private func createPlaceDetail() {
        guard let name = destination?.FinalSpot.0,
              let picture = UIImage(named: name) else {
            fatalError("name or picture is not found")
        }
        self.placeDetail = PlaceDetail(name: name, Picture: picture)
        presenter?.didCreatePlaceDetail()
    }
    
    func changePlace() {
        
        if let seq = destination?.spotAvailable.keys {
            guard let currentIndex = Array(seq)
                .firstIndex(of: self.placeDetail!.name) else {
                    fatalError("index not found Code logic error")
                }
            
            var name = Array(seq)[currentIndex + 1]
            
            destination?.FinalSpot = (name, destination! .spotAvailable[name]!)
        }
        
        // MARK: Will also run the place creation as well
        self.createDirection()
    }
    
}

extension ResultInteractor : locationUpdateProtocol {

    func updateLocation(clLocation: CLLocation) {
        self.userCurrentLocation = clLocation
        createDirection()
    }
    
    
}
