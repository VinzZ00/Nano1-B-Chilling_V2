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
    var mapview : MKMapView {get set}
    
    func showDestination(dest : Destination)
    func showPlaceDetail(placeDetail : PlaceDetail)
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
    
    func showDestination(dest: Destination) {
        // MARK: setup mapview
        mapview.showsUserLocation = true
        mapview.removeAnnotations(mapview.annotations)
        mapview.addAnnotation(MKPlacemark(coordinate: dest.FinalSpot.1.coordinate))
    }
    
    func showPlaceDetail(placeDetail : PlaceDetail) {
        self.placeImageView = UIImageView(image: placeDetail.Picture)
        self.placeNameLabel.text = placeDetail.name
    }
    
    
}
