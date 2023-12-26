//
//  HomePresenter.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 25/12/23.
//

import Foundation
import CoreLocation

protocol HomePresenterProtocol : AnyObject {
    var view : HomeViewController? { get set }
    var interactor : HomeInteractorProtocol? { get set }
    var router : HomeRouterProtocol? { get set }
    func didCreateDestination()
    func saveDestination(dest : Destination)
}

class HomePresenter : HomePresenterProtocol {
    weak var view : HomeViewController?
    var interactor : HomeInteractorProtocol?
    var router : HomeRouterProtocol?
    
    func saveDestination(dest : Destination) {
        interactor?.createDestination(destination: dest)
    }
    
    func didCreateDestination() {
        router?.presentResultPage()
    }
}
