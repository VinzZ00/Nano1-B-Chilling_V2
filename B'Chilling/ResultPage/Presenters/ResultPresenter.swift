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
    
    func didCreatePolyline()
    func didCreatePlaceDetail()
}

class ResultPresenter : ResultPresenterProtocol {
    weak var view : ResultViewProtocol?
    var interactor: ResultInteractorProtocol?
    var router : ResultRouterProtocol?
    
    func viewDidLoad() {
        interactor?.startUpdatingLocation()
        interactor?.createMKPolyline()
    }
}

extension ResultPresenter : InteractorOutputProtocol {
    func didCreatePlaceDetail() {
        if let placeDetail = interactor?.placeDetail {
            view?.showPlaceDetail(placeDetail : placeDetail)
        }
    }
    
    func didCreatePolyline() {
        if let poly = interactor?.polyline {
            view?.mapview.removeOverlays((view?.mapview.overlays) ?? [])
            view?.mapview.addOverlay(poly)
            if let destination = interactor?.destination {
                view?.showDestination(dest: destination)
            }
        }
        
    }
}
