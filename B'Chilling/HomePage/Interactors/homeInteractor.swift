//
//  Interactors.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 25/12/23.
//

import Foundation
import CoreLocation

protocol HomeInteractorProtocol : AnyObject{
    var userDestination : Destination? {set get}
    var presenter : HomePresenterProtocol? { get set }
    func createDestination(destination : Destination)
}

class homeInteractor : HomeInteractorProtocol {
    
    weak var presenter : HomePresenterProtocol?
    var userDestination = Destination.shared

    func createDestination(destination : Destination) {
        userDestination = destination
        presenter?.didCreateDestination()
    }
    
}
