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
    var sheet : CustomSheet = CustomSheet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        // MARK: Setup Component
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor(hex: "#35E582", alpha: 1.0), for: .normal)
        startButton.titleLabel?.backgroundColor = .white
        
        suggestOtherButton.setTitle("Suggest Other Place...", for: .normal)
        suggestOtherButton.setTitleColor(.white, for: .normal)
        
        mapview.delegate = self
        mapview.showsUserLocation = true
        mapview.userTrackingMode = .followWithHeading
        
        sheet.resultviewController = self
        
        
//        innerView.backgroundColor = UIColor(hex: "#14CAE1", alpha: 1)
//        innerView.layer.cornerRadius = 43
        
        // MARK: Adding to parent View
        view.addSubview(mapview)
        view.addSubview(sheet)
        // MARK: Layout Setup
        layoutSetup()
        
    }
    
    func layoutSetup() {
        view.subviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mapview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            sheet.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            sheet.heightAnchor.constraint(equalToConstant: 488),
            sheet.widthAnchor.constraint(equalToConstant: view.bounds.width),
            sheet.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
    }
    
    
}

extension ResultViewController : ResultViewProtocol {
    
    
    func showDestination(dest: Destination) {
        // MARK: setup mapview
        mapview.showsUserLocation = true
        mapview.removeAnnotations(mapview.annotations)
        
        let ann = MKPointAnnotation()
        ann.coordinate = dest.FinalSpot.1.coordinate
        ann.title = dest.FinalSpot.0
        
        mapview.addAnnotation(ann)
    }
    
    func showPlaceDetail(placeDetail : PlaceDetail) {
        self.placeImageView = UIImageView(image: placeDetail.Picture)
        self.placeNameLabel.text = placeDetail.name
        
        self.sheet.placeDetail = placeDetail
    }
    
}

extension ResultViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 5  
        return renderer
    }
}
