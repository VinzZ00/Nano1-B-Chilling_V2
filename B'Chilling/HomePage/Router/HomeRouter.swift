//
//  ViewController.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 25/12/23.
//

import UIKit

protocol HomeRouterProtocol : AnyObject {
    static func createHomeModule() -> UIViewController
    func presentResultPage(from homeView : HomeViewProtocol, destination : Destination)
}

class HomeRouter : HomeRouterProtocol {
    func presentResultPage(from homeView : HomeViewProtocol, destination : Destination) {
        // MARK: SETTING RESULT DAN SHOW PAGE
        var view = ResultRouter.createResultModule(destination: destination)
        
        guard let homeView = homeView as? HomeViewController else {
            fatalError("home view controller is not detected")
        }
        
        homeView.navigationController?.pushViewController(view, animated: true)
        
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

