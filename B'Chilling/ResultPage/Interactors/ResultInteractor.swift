//
//  ResultPageInteractor.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 28/12/23.
//

import Foundation

protocol ResultInteractorProtocol : AnyObject {
    var presenter : ResultPresenterProtocol? {get set}
}

class ResultInteractor : ResultInteractorProtocol {
    weak var presenter: ResultPresenterProtocol?
}
