//
//  CustomSheet.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 31/12/23.
//

import UIKit

class CustomSheet: UIView {

    var placeDetail: PlaceDetail?
    
    var sheetInitLabel : UILabel = UILabel()
    var route: [String]?
    var modalDismissImage : UIImageView = UIImageView()
    var placeImage : UIImageView = UIImageView()
    var placeName : UILabel = UILabel()
    var endRouteButton : UIButton = UIButton()
    
    private var isSmall = true
    private var isRotated = false
    private var height : NSLayoutConstraint?
    
    var resultviewController : ResultViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 43
        
        // MARK: Setup Component
        sheetInitLabel.text = "Direction details"
        sheetInitLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        modalDismissImage.image = UIImage(systemName: "chevron.up")?.withRenderingMode(.alwaysTemplate)
        modalDismissImage.tintColor = .black
        
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
        sheetLayoutSetup()
    }
    
    func sheetLayoutSetup() {
        if isSmall {
            // MARK: If Rotated then return it to init state
            if isRotated {
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                    self.modalDismissImage.transform = CGAffineTransform.identity
                    self.isRotated = false
                }
            }
            
            
            
            self.addSubview(modalDismissImage)
            self.addSubview(sheetInitLabel)
            
            self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            
            NSLayoutConstraint.activate([
                
                // Modal Dismiss
                modalDismissImage.widthAnchor.constraint(equalToConstant: 52),
                modalDismissImage.heightAnchor.constraint(equalToConstant: 29),
                modalDismissImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 11.4),
                modalDismissImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                // Sheet Init Label
                sheetInitLabel.topAnchor.constraint(equalTo: modalDismissImage.bottomAnchor, constant: 10),
                sheetInitLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
            ])
            
            self.height = self.heightAnchor.constraint(equalToConstant: 131)
            height!.isActive = true

        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func panGesture(_ sender : UIPanGestureRecognizer) {
        switch sender.state {
        case .changed :
            guard let height = self.height else { fatalError("Height constant is nill") }
            var nHeight = height.constant
            let translation = sender.translation(in: self)
            nHeight += (-translation.y/6)
            print("translation : \(height.constant)")
            // Set the new height for the view
            
            
            
            if nHeight < 131 {
                self.height?.isActive = false
                self.height?.constant = 131
                self.height?.isActive = true
            } else if nHeight > 488 {
                self.height?.isActive = false
                self.height?.constant = 488
                self.height?.isActive = true
            } else {
                self.height?.isActive = false
                self.height?.constant = nHeight
                self.height?.isActive = true
            }
            
            self.layoutIfNeeded()
        case .ended :
            
            guard let height = height?.constant else { return  }
            
            if height > (131 + ((488 - 131) / 2)) {
                self.height?.isActive = false
                self.height?.constant = 488
                self.height?.isActive = true
                
                self.layoutIfNeeded()
                
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                    self.modalDismissImage.transform = CGAffineTransform(rotationAngle: .pi)
                }
                
                isRotated = true
                isSmall = false
            } else {
                self.height?.isActive = false
                self.height?.constant = 131
                self.height?.isActive = true
                
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                    self.modalDismissImage.transform = CGAffineTransform.identity
                }
                
                isRotated = false
                isSmall = true
            }
        default :
            break
        }
    }
    
    @objc func endRouteButtonHandler(_ sender : UIButton) {
        print("go back to home page")
        guard let vc = resultviewController as? UIViewController else {
            fatalError("ResultViewController is not registered")
        }
        if let navController = vc.navigationController {
            navController.dismiss(animated: true, completion: nil)
        }
    }
}


