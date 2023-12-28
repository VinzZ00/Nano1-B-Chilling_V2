//
//  ResultViewController.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 28/12/23.
//

import UIKit

protocol ResultViewProtocol : AnyObject {
    var presenter : ResultPresenterProtocol? { get set }
}

class ResultViewController: UIViewController, ResultViewProtocol{
    
    var presenter: ResultPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
