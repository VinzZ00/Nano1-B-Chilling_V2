//
//  DestinationSheetViewController.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 30/12/23.
//

import UIKit

protocol DestinationSheetViewProtocol : AnyObject {
    var presenter : ResultPresenterProtocol? {get set}
    
    var placeDetail : PlaceDetail? {get set}
    var route : [String]? {get set}
    
    func didChangeDestination()
    
}



class DestinationSheetViewController: UIViewController {
    var placeDetail: PlaceDetail?
    
    var sheetInitLabel : UILabel = UILabel()
    var route: [String]?
    var modalDismissImage : UIImageView = UIImageView()
    var placeImage : UIImageView = UIImageView()
    var placeName : UILabel = UILabel()
    var endRouteButton : UIButton = UIButton()
    var presenter: ResultPresenterProtocol?
    
    private var isRotated : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 43
        view.backgroundColor = .white
        
        // MARK: Setup Component
        sheetInitLabel.text = "Direction details"
        sheetInitLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        modalDismissImage.image = UIImage(systemName: "chevron.up")
        
        placeImage.image = placeDetail?.Picture
        placeImage.layer.cornerRadius = 23
        placeImage.contentMode = .scaleToFill
        placeImage.clipsToBounds = true
        
        placeName.text = placeDetail?.name
        placeName.font = .systemFont(ofSize: 36, weight: .semibold)
        
        // TODO: Table View Here
        
        endRouteButton.setTitle("End Route!", for: .normal)
        endRouteButton.backgroundColor = .init(hex: "#FF5757")
        endRouteButton.titleLabel?.textColor = .white
        endRouteButton.addTarget(self, action: #selector(endRouteButtonHandler(_:)), for: .touchUpInside)
        
//        // MARK: Adding Component
//        view.addSubview(modalDismissButton)
//        view.addSubview(placeName)
//        view.addSubview(placeImage)
//        // TODO: add table view to the view as well
//        view.addSubview(endRouteButton)
        
        // MARK: Setup Sheet
        setupPagePresentation()
    }
    
    func setupPagePresentation() {
        preferredContentSize = CGSize(width: view.bounds.width, height: 131)
        modalPresentationStyle = .pageSheet
        presentationController?.delegate = self
        
        if let sheetController = presentationController as? UISheetPresentationController {
            sheetController.detents = [
                .custom(identifier: UISheetPresentationController.Detent.Identifier("initialState"), resolver: { context in
                    return 131
                }),
//                .custom(identifier: UISheetPresentationController.Detent.Identifier("presentState"), resolver: {
//                    [unowned self] context in
//                    return view.bounds.height * 0.5
//                })
                    .medium()
            ]
            sheetController.selectedDetentIdentifier = .init("initialState")
        }
    }
    
    @objc func endRouteButtonHandler(_ sender : UIButton) {
        print("go back to home page")
        if let navController = navigationController {
            navController.dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension DestinationSheetViewController : UISheetPresentationControllerDelegate {
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        false
    }
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        guard let identifier = sheetPresentationController.selectedDetentIdentifier else { return }
        
        print("identifier : \(identifier)")
        
        switch sheetPresentationController.selectedDetentIdentifier {
        case .init("initialState"):
            
            // MARK: If Rotated then return it to init state
            if isRotated {
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                    self.modalDismissImage.transform = CGAffineTransform.identity
                    self.isRotated = false
                }
            }
            
            view.addSubview(modalDismissImage)
            view.addSubview(sheetInitLabel)
            
            view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            
            NSLayoutConstraint.activate([
                
                // Modal Dismiss
                modalDismissImage.widthAnchor.constraint(equalToConstant: 52),
                modalDismissImage.heightAnchor.constraint(equalToConstant: 29),
                modalDismissImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 11.4),
                modalDismissImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                // Sheet Init Label
                sheetInitLabel.topAnchor.constraint(equalTo: modalDismissImage.bottomAnchor, constant: 10),
                sheetInitLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
            
            
        case .init("com.apple.UIKit.medium") :
            break
        case .none :
            // MARK: If Rotated then return it to init state
            if isRotated {
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                    self.modalDismissImage.transform = CGAffineTransform.identity
                    self.isRotated = false
                }
            }
            
            view.addSubview(modalDismissImage)
            view.addSubview(sheetInitLabel)
            
            view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            
            NSLayoutConstraint.activate([
                
                // Modal Dismiss
                modalDismissImage.widthAnchor.constraint(equalToConstant: 52),
                modalDismissImage.heightAnchor.constraint(equalToConstant: 29),
                modalDismissImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 11.4),
                modalDismissImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                // Sheet Init Label
                sheetInitLabel.topAnchor.constraint(equalTo: modalDismissImage.bottomAnchor, constant: 10),
                sheetInitLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        default:
            fatalError("unkown state of the sheet")
        }
        
    }
}

extension DestinationSheetViewController : DestinationSheetViewProtocol {
    func didChangeDestination() {
        
    }
}

