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
    func didReceiveLocation()
}

class ResultPresenter : ResultPresenterProtocol {
    weak var view : ResultViewProtocol?
    var interactor: ResultInteractorProtocol?
    var router : ResultRouterProtocol?
    
    func viewDidLoad() {
        if let destination = interactor?.destination {
            view?.showDestination(dest: destination)
        }
    }
}

extension ResultPresenter : InteractorOutputProtocol {
    func didReceiveLocation() {
        
    }
}
