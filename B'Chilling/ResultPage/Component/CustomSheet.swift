//
//  CustomSheet.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 31/12/23.
//

import UIKit
import CoreLocation.CLMonitor

protocol CustomSheetDelegate {
    func endRouteButtonHandle(_ sender : UIButton)
}




class CustomSheet: UIView {
    // Computed Property
    var routes : [String]?
    var placeDetail: PlaceDetail? {
        didSet {
            self.placeName.text = placeDetail?.name
            self.placeImage.image = placeDetail?.Picture
        }
    }
    
    // MARK: Delegate
    var delegate : CustomSheetDelegate?
    
    // MARK: Component
    var sheetInitLabel : UILabel = UILabel()
    var modalDismissImage : UIImageView = UIImageView()
    var placeImage : UIImageView = UIImageView()
    var placeName : UILabel = UILabel()
    var endRouteButton : UIButton = UIButton()
    var tableview : UITableView = {
        var tv = UITableView()
        tv.backgroundColor = .white
        tv.register(RouteTableViewCell.self, forCellReuseIdentifier: "routeCell")
        tv.backgroundColor = .white
        return tv
    }()
    
    let horizontalLine : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Constraint
    private var isSmall = true
    private var isRotated = false
    private var height : NSLayoutConstraint?
    private var isResizing : Bool = false
    
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Setup
    func setup() {
        // MARK: Setup Component
        sheetInitLabel.text = "Direction details"
        sheetInitLabel.font = .systemFont(ofSize: 18, weight: .medium)
        sheetInitLabel.textColor = .black
        
        modalDismissImage.image = UIImage(systemName: "chevron.up")?.withRenderingMode(.alwaysTemplate)
        modalDismissImage.tintColor = .black
        
        placeImage.image = placeDetail?.Picture ?? UIImage(systemName: "photo.artframe")
        placeImage.layer.cornerRadius = 23
        placeImage.contentMode = .scaleToFill
        placeImage.clipsToBounds = true
        
        placeName.text = placeDetail?.name
        placeName.font = .systemFont(ofSize: 36, weight: .semibold)
        placeName.lineBreakMode = .byWordWrapping
        placeName.numberOfLines = 0
        placeName.textColor = .black
        
        // TODO: Table View Here
        tableview.dataSource = self
        
        endRouteButton.setTitle("End Route!", for: .normal)
        endRouteButton.backgroundColor = .init(hex: "#FF5757")
        endRouteButton.titleLabel?.textColor = .white
        endRouteButton.addTarget(self, action: #selector(endRouteButtonHandler(_:)), for: .touchUpInside)
        endRouteButton.layer.cornerRadius = 13.5
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        
        // MARK: View Setup
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panGesture)
        self.backgroundColor = .white
        self.layer.cornerRadius = 43
        
        // MARK: Setup Sheet
        sheetLayoutSetup()
    }
    
    // MARK: Layout Setup
    func sheetLayoutSetup() {
        
        
        if isSmall { // if the sheet is in small
            subviews.forEach { v in
                v.removeFromSuperview()
            }
            
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

        
        } else { // If the sheet is in full size
            subviews.forEach{
                $0.removeFromSuperview()
            }
            
            
            self.addSubview(modalDismissImage)
            self.addSubview(placeImage)
            self.addSubview(placeName)
            self.addSubview(horizontalLine)
            self.addSubview(tableview)
            self.addSubview(endRouteButton)
            
            
            //MARK: add constraint
            self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false
            }
            NSLayoutConstraint.activate([
                
                // Modal Dismiss
                modalDismissImage.widthAnchor.constraint(equalToConstant: 52),
                modalDismissImage.heightAnchor.constraint(equalToConstant: 29),
                modalDismissImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 11.4),
                modalDismissImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                // Place Image
                placeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 41),
                placeImage.topAnchor.constraint(equalTo: modalDismissImage.bottomAnchor, constant: 14.6),
                placeImage.heightAnchor.constraint(equalToConstant: 86),
                placeImage.widthAnchor.constraint(equalToConstant: 86),
                
                // Place Name
                placeName.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: 23.5),
                placeName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 65.5),
                placeName.centerYAnchor.constraint(equalTo: placeImage.centerYAnchor),
                
                // Horizontal Line
                horizontalLine.topAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: 17.5),
                horizontalLine.heightAnchor.constraint(equalToConstant: 1),
                horizontalLine.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
                horizontalLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
//                // Table View
                tableview.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 15.5),
                tableview.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                tableview.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
                tableview.heightAnchor.constraint(equalToConstant: 162),
                
                // End Route Button
                endRouteButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -33),
                endRouteButton.widthAnchor.constraint(equalToConstant: 155),
                endRouteButton.heightAnchor.constraint(equalToConstant: 40),
                endRouteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        }
    }
    
    @objc func panGesture(_ sender : UIPanGestureRecognizer) {
        switch sender.state {
        case .changed :
            guard let height = self.height else { fatalError("Height constant is nill") }
            var nHeight = height.constant
            let translation = sender.translation(in: self)
            let velocity = sender.velocity(in: self)
            nHeight += (-translation.y)
            
            if abs(velocity.y) < 500 {
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
            }
            
            sender.setTranslation(.zero, in: self)
        case .ended :
            guard let height = height?.constant else { return  }
            
            if height > (131 + ((488 - 131) / 2)) {
                
                let last = isSmall
                
                
                
                self.layoutIfNeeded()
                
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                    self.modalDismissImage.transform = CGAffineTransform(rotationAngle: .pi)
                }
                
                
                
                if !isSmall {
                    self.height?.isActive = false
                    self.height?.constant = 488
                    self.height?.isActive = true
                }
                
                isRotated = true
                if self.height!.constant >= 131 {
                    isSmall = false
                }
                
                if last != self.isSmall {
                    sheetLayoutSetup()
                }
                
            } else {
                
                let last = self.isSmall
                
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                    self.modalDismissImage.transform = CGAffineTransform.identity
                }
                
                
                if isSmall {
                    self.height?.isActive = false
                    self.height?.constant = 131
                    self.height?.isActive = true
                }
                
                isRotated = false
                if self.height!.constant < 488 {
                    isSmall = true
                }
                
                if last != self.isSmall {
                    sheetLayoutSetup()
                }
                
            }
        default :
            break
        }
    }
    
    @objc func endRouteButtonHandler(_ sender : UIButton) {
        delegate?.endRouteButtonHandle(sender)
    }
}

extension CustomSheet : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let routes = routes else {
            return 0
        }
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableview.dequeueReusableCell(withIdentifier: "routeCell") as? RouteTableViewCell
        else {
            fatalError("cell can't be convert into routeTableViewCell")
        }
        
        guard let routes = routes else {
            print("Routes is nil")
            cell.routeDirectionText = nil
            return cell
        }
        
        cell.routeDirectionText = "\(indexPath.row + 1). \(routes[indexPath.row])"
        return cell
    }
}


