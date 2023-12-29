//
//  ResultPageRouter.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 28/12/23.
//

import Foundation

protocol ResultRouterProtocol : AnyObject {
    
    static func createResultModule(destination : Destination)
}

class ResultRouter : ResultRouterProtocol {
    
    static func createResultModule(destination: Destination) {
        // MARK: Init
        let router : ResultRouterProtocol = ResultRouter()
        let presenter : ResultPresenterProtocol & InteractorOutputProtocol = ResultPresenter()
        let interactor : ResultInteractorProtocol = ResultInteractor()
        let view : ResultViewProtocol = ResultViewController()
        
        
        // MARK: Adding dependency
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.destination = destination
        
        view.presenter = presenter
        
    }
    
}
