//
//  HomeViewController.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 25/12/23.
//

import UIKit

class HomeViewController: UIViewController {
    
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
    
    @objc func handleTapGest(_ sender : UITapGestureRecognizer) {
        if let label = sender.view as? UILabel
        {
            switch label.text! {
            case "🥶":
                print("Chill")
            case "😕":
                print("blue")
            default :
                print("default")
            }
        }
        
        print("tapped")
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
