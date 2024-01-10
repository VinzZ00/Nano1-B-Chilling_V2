//
//  ResultPageRouter.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 28/12/23.
//

import Foundation
import UIKit

protocol ResultRouterProtocol : AnyObject {

    static func createResultModule(destination : Destination) -> UIViewController
    func backToHome(from view : ResultViewProtocol)
}

class ResultRouter : ResultRouterProtocol {
    
    static func createResultModule(destination: Destination) -> UIViewController{
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
        
        return view as! ResultViewController
    }
    
    func backToHome(from view: ResultViewProtocol) {
        guard let view = view as? ResultViewController else {
            fatalError("this is not a result View Controller")
        }
        view
            .navigationController?
            .popViewController(animated: true)
    }
    
}
