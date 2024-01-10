//
//  RouteTableViewCell.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 03/01/24.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    // MARK: Component
//    let horizontalLine : UIView = {
//        let view = UIView()
//        view.backgroundColor = .black
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    let routeDirectionLabel : UILabel = {
        var l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 14, weight: .regular)
        return l
    }()
    
    var routeDirectionText : String? {
        didSet {
            routeDirectionLabel.text = routeDirectionText
        }
    }

    
    // Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        // Setup View
        routeDirectionLabel.text = routeDirectionText
        routeDirectionLabel.textAlignment = .left
        routeDirectionLabel.numberOfLines = 2
        routeDirectionLabel.lineBreakMode = .byWordWrapping
        
        // Adding to parent view
        contentView.addSubview(routeDirectionLabel)
//        contentView.addSubview(horizontalLine)
        
        // Setup layout
        // Route Direction Label
        routeDirectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18).isActive = true
        routeDirectionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        routeDirectionLabel.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        // Horizontal Line
//        horizontalLine.topAnchor.constraint(equalTo: routeDirectionLabel.bottomAnchor, constant: 16).isActive = true
//        horizontalLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        horizontalLine.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
//        horizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
