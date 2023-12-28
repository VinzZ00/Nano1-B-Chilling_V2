//
//  ResultPagePresenter.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 28/12/23.
//

import Foundation

protocol ResultPresenterProtocol : AnyObject{
    var view : resultViewProtocol? { get set }
    var interactor : ResultInteractorProtocol? {get set}
    var router : ResultRouterProtocol? {get set}
}

protocol InteractorOutputProtocol : AnyObject {
    
}

class ResultPresenter : ResultPresenterProtocol {
    weak var view : resultViewProtocol?
    var interactor: ResultInteractorProtocol?
    var router : ResultRouterProtocol?
}

extension ResultPresenter : InteractorOutputProtocol {
    
}
