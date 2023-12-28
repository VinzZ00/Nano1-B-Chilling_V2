//
//  HomeViewController.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 25/12/23.
//

import UIKit
import CoreLocation

protocol HomeViewProtocol : AnyObject {
    var presenter : HomePresenterProtocol? { get set }
}

class HomeViewController: UIViewController, HomeViewProtocol {
    
    let LogoImage : UIImage = UIImage(named: "Logo")!
    var InnerUIView : UIView!
    var TextDescription : UILabel!
    var imageView : UIImageView!
    var exploreButton : UIButton!
    var innerView : UIView!
    var commonColor : UIColor = UIColor(red: 20/255, green: 202/255, blue: 225/255, alpha: 1)
    var presenter : HomePresenterProtocol?
    
    var users : [UserData] = {
        return [UserData(), UserData(), UserData()]
    }()
                 
    var firstCell : CustomFormCell = {
        return CustomFormCell()
    }()
    
    var secondCell : CustomFormCell = {
        return CustomFormCell()
    }()
    
    var thirdCell : CustomFormCell = {
        return CustomFormCell()
    }()
    
    @objc func exploreButtonHandle(_ sender : UIButton) {
        
        var (blue, happy, stress) = (0,0,0)
        
        
        // Sum up emotions
        if firstCell.emotion == .chill {
            happy += 1;
        } else if firstCell.emotion == .blue {
            blue += 1;
        } else if firstCell.emotion == .stress {
            stress += 1;
        }
        
        if secondCell.emotion == .chill {
            happy += 1;
        } else if secondCell.emotion == .blue {
            blue += 1;
        } else if secondCell.emotion == .stress {
            stress += 1;
        }
        
        if thirdCell.emotion == .chill {
            happy += 1;
        } else if thirdCell.emotion == .blue {
            blue += 1;
        } else if thirdCell.emotion == .stress {
            stress += 1;
        }
        
        var domMood : Emotions?
        // Determine dominating emotion
        if blue > 1 {
            domMood = .blue
        } else if happy > 1 {
            domMood = .chill
        } else if stress > 1 {
            domMood = .stress
        } else if blue == 0 && stress != 0 && happy != 0 {
            domMood = .chillnStress
        } else if stress == 0 && happy != 0 && blue != 0 {
            domMood = .bluenchill
        } else if happy == 0 && stress != 0 && blue != 0 {
            domMood = .bluenstress
        } else {
            domMood = .AllCanDo
        }
        
        // assess available spot
        var spotAvailable : [String : CLLocation]?
        switch domMood {
        case .chill :
            spotAvailable =
            [
                "Kumolo BSD" : Destination.spots["Kumolo BSD"]!,
                "Q’Billiard" : Destination.spots["Q’Billiard"]!,
                "Techpolitan Board Game" : Destination.spots["Techpolitan Board Game"]!
            ]
        case .blue :
            spotAvailable = [
                "Food Court The Breeze" : Destination.spots["Food Court The Breeze"]!,
                "Lake View Breeze" : Destination.spots["Lake View Breeze"]!,
                "Walking Track Breeze" : Destination.spots["Walking Track Breeze"]!
            ]
        case .stress :
            spotAvailable = [
                "Sinar Djaya" : Destination.spots["Sinar Djaya"]!,
                "Spincity" : Destination.spots["Spincity"]!,
                "Gold Gym" : Destination.spots["Gold Gym"]!
            ]
        case .bluenchill :
            spotAvailable = [
                "Food Court The Breeze" : Destination.spots["Food Court The Breeze"]!,
                "Kumolo BSD" : Destination.spots["Kumolo BSD"]!,
                "Lake View Breeze" : Destination.spots["Lake View Breeze"]!
            ]
        case .bluenstress :
            spotAvailable = [
                "Lake View Breeze" : Destination.spots["Lake View Breeze"]!,
                "Spincity" : Destination.spots["Spincity"]!,
                "Walking Track Breeze" : Destination.spots["Walking Track Breeze"]!
            ]
            
        case .chillnStress :
            spotAvailable = [
                "Sinar Djaya" : Destination.spots["Sinar Djaya"]!,
                "Gold Gym" : Destination.spots["Gold Gym"]!,
                "Q’Billiard" : Destination.spots["Q’Billiard"]!
            ]
        case .AllCanDo :
            spotAvailable = [
                "Kumolo BSD" : Destination.spots["Kumolo BSD"]!,
                "Food Court The Breeze" : Destination.spots["Food Court The Breeze"]!,
                "Sinar Djaya" : Destination.spots["Sinar Djaya"]!
            ]
        case .none :
            fatalError("Unexpected nil in Mood in Dominating Mood")
        }
        
        if
            let spotAvailable = spotAvailable,
            let domMood = domMood
        {
            let destination = Destination(spotAvailable: spotAvailable, dominatingMood: domMood)
            self.presenter?.saveDestination(dest: destination)
        }
        
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .white
        
        //MARK: Logo
        imageView = UIImageView(image: LogoImage)
        
        //MARK: Inner View
        innerView = UIView()
        innerView.layer.cornerRadius = 43
        innerView.backgroundColor = commonColor

        TextDescription = UILabel()
        TextDescription?.text = "Please list your chill friends bellow,"
        TextDescription.textColor = .white
        
        
        //MARK: Explore Button
        exploreButton = UIButton(type: .system)
        exploreButton.setTitle("Explore", for: .normal)
        exploreButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        exploreButton.setTitleColor(commonColor, for: .normal)
        exploreButton.backgroundColor = .white
        exploreButton.layer.cornerRadius = 22
        exploreButton.addTarget(self, action: #selector(exploreButtonHandle(_:)), for: .touchUpInside)
        
        innerView.addSubview(TextDescription)
        innerView.addSubview(firstCell)
        innerView.addSubview(secondCell)
        innerView.addSubview(thirdCell)
        innerView.addSubview(exploreButton)
        innerLayoutSetup()
        
        self.view.addSubview(imageView)
        self.view.addSubview(innerView)
        parentLayoutSetup()
    }
    
    func innerLayoutSetup() {
        innerView.subviews.forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
//
        NSLayoutConstraint.activate([
            TextDescription.topAnchor.constraint(equalTo: innerView.topAnchor, constant: 48),
            TextDescription.heightAnchor.constraint(equalToConstant: 58),
            TextDescription.centerXAnchor.constraint(equalTo: innerView.centerXAnchor),
            
            
            firstCell.topAnchor.constraint(equalTo: TextDescription.bottomAnchor, constant: 33),
            firstCell.centerXAnchor.constraint(equalTo: innerView.centerXAnchor),
            firstCell.widthAnchor.constraint(equalToConstant: 228),
            firstCell.heightAnchor.constraint(equalToConstant: 96),
            
            secondCell.topAnchor.constraint(equalTo: firstCell.bottomAnchor, constant: 11),
            secondCell.centerXAnchor.constraint(equalTo: innerView.centerXAnchor),
            secondCell.widthAnchor.constraint(equalToConstant: 228),
            secondCell.heightAnchor.constraint(equalToConstant: 96),
            
            thirdCell.topAnchor.constraint(equalTo: secondCell.bottomAnchor, constant: 11),
            thirdCell.centerXAnchor.constraint(equalTo: innerView.centerXAnchor),
            thirdCell.widthAnchor.constraint(equalToConstant: 228),
            thirdCell.heightAnchor.constraint(equalToConstant: 96),
            
            exploreButton.topAnchor.constraint(equalTo: thirdCell.bottomAnchor, constant: 51),
            exploreButton.widthAnchor.constraint(equalToConstant: 151),
            exploreButton.heightAnchor.constraint(equalToConstant: 43),
            exploreButton.centerXAnchor.constraint(equalTo: innerView.centerXAnchor)
            
        ])
        
    }

    
    func parentLayoutSetup() {
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        self.view.subviews.forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            innerView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            innerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            innerView.widthAnchor.constraint(equalToConstant: 393),
            innerView.heightAnchor.constraint(equalToConstant: 671)
        ])
        
        
    }
}
