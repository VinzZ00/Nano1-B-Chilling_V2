//
//  ResultPagePresenter.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 28/12/23.
//

import Foundation

protocol ResultPresenterProtocol : AnyObject{
    var view : ResultViewProtocol? { get set }
    var interactor : ResultInteractorProtocol? {get set}
    var router : ResultRouterProtocol? {get set}
    
    func viewDidLoad()
}

protocol InteractorOutputProtocol : AnyObject {
//    func didReceiveLocation()
    
    func didCreateDirection()
    func didCreatePlaceDetail()
}

class ResultPresenter : ResultPresenterProtocol {
    weak var view : ResultViewProtocol?
    var interactor: ResultInteractorProtocol?
    var router : ResultRouterProtocol?
    
    func viewDidLoad() {
        interactor?.startUpdatingLocation()
        interactor?.createDirection()
    }
}

extension ResultPresenter : InteractorOutputProtocol {
    func didCreatePlaceDetail() {
        if let placeDetail = interactor?.placeDetail {
            view?.showPlaceDetail(placeDetail : placeDetail)
        }
    }
    
    func didCreateDirection() {
        if 
            let poly = interactor?.polyline,
            let destination = interactor?.destination,
            let routes = interactor?.routes
        {
            view?.showDestination(dest: destination, poly: poly, routes: routes)
        }
    }
}
