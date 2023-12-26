//
//  ViewController.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 25/12/23.
//

import UIKit

protocol HomeRouterProtocol : AnyObject {
    static func createHomeModule() -> UIViewController
    func presentResultPage()
}

class HomeRouter : HomeRouterProtocol {
    func presentResultPage() {
        // MARK: SETTING RESULT DAN SHOW PAGE
    }
    
    static func createHomeModule() -> UIViewController {
        
        let navController = UINavigationController(rootViewController: HomeViewController())
        
        guard let HomeViewController = navController.topViewController as? HomeViewController else {
            fatalError("wrong view Controller on top")
        }
        
        let presenter : HomePresenterProtocol = HomePresenter()
        let interactor : HomeInteractorProtocol = homeInteractor()
        let router : HomeRouterProtocol = HomeRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = HomeViewController
        interactor.presenter = presenter
        HomeViewController.presenter = presenter
        
        return navController
    }
    


}

