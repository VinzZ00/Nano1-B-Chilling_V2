//
//  ResultViewController.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 28/12/23.
//

import UIKit
import MapKit

protocol ResultViewProtocol : AnyObject {
    var presenter : ResultPresenterProtocol? { get set }
    
    func showDestination(dest : Destination)
    
    func updateMap()
}

class ResultViewController: UIViewController{
    
    var presenter: ResultPresenterProtocol?
    
    // MARK: Component
    var placeImageView : UIImageView = UIImageView()
    var placeNameLabel : UILabel = UILabel()
    var startButton : UIButton = UIButton()
    var suggestOtherButton : UIButton = UIButton()
    var ArrowButton : UIButton = UIButton()
    var mapview : MKMapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension ResultViewController : ResultViewProtocol {
    func updateMap() {
        // MARK: Update mapview
    }
    
    func showDestination(dest: Destination) {
        // MARK: setup mapview
    }
    
    
}
