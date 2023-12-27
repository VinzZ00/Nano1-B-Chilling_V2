//
//  destination.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 26/12/23.
//

import Foundation
import CoreLocation

struct Destination {
    var spotAvailable : [String : CLLocation]
    var dominatingMood : Emotions
    static var shared : Destination?
    
    static var spots : [String: CLLocation] =
    [
        "Kumolo BSD" : CLLocation(latitude: -6.300620, longitude: 106.654335),
        "Q’Billiard" : CLLocation(latitude: -6.301880, longitude: 106.653560),
        "Techpolitan Board Game" : CLLocation(latitude: -6.302897, longitude: 106.654457),
        
        "Food Court The Breeze" : CLLocation(latitude : -6.301582, longitude : 106.655139),
        "Lake View Breeze" : CLLocation(latitude: -6.301937, longitude: 106.654243),
        "Walking Track Breeze" : CLLocation(latitude: -6.301616, longitude: 106.651096),
        
        "Sinar Djaya" : CLLocation(latitude: -6.301985, longitude: 106.654779),
        "Spincity" : CLLocation(latitude: -6.302706, longitude: 106.655111),
        "Gold Gym" : CLLocation(latitude: -6.302001, longitude: 106.654678)
        
    ]
}
