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
    
    func showDestination(dest: Destination, poly : MKPolyline, routes : [String])
    func showPlaceDetail(placeDetail : PlaceDetail)
}

class ResultViewController: UIViewController{
    
    var presenter: ResultPresenterProtocol?
    
    // MARK: Component
    var mapview : MKMapView = MKMapView()
    var sheet : CustomSheet = CustomSheet()
    let navigationTitleLogo = UIImageView(image: UIImage(named: "LongLogo"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        navigationTitleLogo.contentMode = .scaleAspectFit
        navigationTitleLogo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Height and width of the logo
            navigationTitleLogo.widthAnchor.constraint(equalToConstant: 246.45),
            navigationTitleLogo.heightAnchor.constraint(equalToConstant: 36.93)
        ])
        
        // Setup the navigationbar
        navigationItem.hidesBackButton = true
        navigationItem.titleView = navigationTitleLogo
        

        view.backgroundColor = .white
        
        // MARK: Setup Component
        mapview.delegate = self
        mapview.showsUserLocation = true
        mapview.userTrackingMode = .followWithHeading
        
        // Setting sheet Delegate to handle the tap on the buttons
        sheet.delegate = self
        
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
            sheet.heightAnchor.constraint(equalToConstant: 488),
            sheet.widthAnchor.constraint(equalToConstant: view.bounds.width),
            sheet.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
    }
    
    
}

extension ResultViewController : ResultViewProtocol {
    
    
    func showDestination(dest: Destination, poly : MKPolyline, routes : [String]) {
        // MARK: setup mapview
        mapview.showsUserLocation = true
        mapview.removeAnnotations(mapview.annotations)
        mapview.removeOverlays((mapview.overlays))
        
        let ann = MKPointAnnotation()
        ann.coordinate = dest.FinalSpot.1.coordinate
        ann.title = dest.FinalSpot.0
        
        mapview.addAnnotation(ann)
        mapview.addOverlay(poly)
        
        sheet.routes = routes
        sheet.tableview.reloadData()
    }
    
    func showPlaceDetail(placeDetail : PlaceDetail) {
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

extension ResultViewController : CustomSheetDelegate {
    func endRouteButtonHandle(_ sender: UIButton) {
        print("go back to home page")
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    
}
