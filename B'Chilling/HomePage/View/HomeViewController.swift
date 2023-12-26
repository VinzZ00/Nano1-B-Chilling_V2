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
    var commonColor : UIColor = UIColor(red: 20, green: 202, blue: 225, alpha: 100)
    var presenter : HomePresenterProtocol?
    
    var users : [CustomFormCell] {
//        CGRect(x: 0, y: 0, width: 228, height: 96)
        let firstPersonForm : CustomFormCell = CustomFormCell()
        let secondPersonForm : CustomFormCell = CustomFormCell()
        let thirdPersonForm : CustomFormCell = CustomFormCell()
        return [firstPersonForm, secondPersonForm, thirdPersonForm]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TextDescription = UILabel()
        TextDescription?.text = "Please list your chill friends bellow,"
        
        imageView = UIImageView(image: LogoImage)
        
//        frame: CGRect(x: 0, y: 0, width: 151, height: 43))
        exploreButton = UIButton(type: .system)
        exploreButton.setTitle("Explore", for: .normal)
        exploreButton.setTitleColor(commonColor, for: .normal)
        exploreButton.backgroundColor = .white
        
//        frame: CGRect(x: 0, y: 0, width: 393, height: 671)
        innerView = UIView()
        
        
        self.view.addSubview(imageView)
        
        innerView.addSubview(TextDescription)
        users.forEach({ formCell in
            innerView.addSubview(formCell)
        })
        innerView.addSubview(exploreButton)
        
        innerView.backgroundColor = commonColor
        
        innerLayoutSetup()
        
        self.view.addSubview(innerView)
        
        parentLayoutSetup()
    }
    
    func innerLayoutSetup() {
        innerView.subviews.forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            TextDescription.topAnchor.constraint(equalTo: innerView.topAnchor, constant: 48),
            TextDescription.heightAnchor.constraint(equalToConstant: 58),
            
            users[0].topAnchor.constraint(equalTo: TextDescription.bottomAnchor, constant: 33),

            users[1].topAnchor.constraint(equalTo: users[0].topAnchor, constant: 11),
            
            users[2].topAnchor.constraint(equalTo: users[1].topAnchor, constant: 11),

            exploreButton.topAnchor.constraint(equalTo: users[2].bottomAnchor, constant: 71),
            exploreButton.widthAnchor.constraint(equalToConstant: 151),
            exploreButton.heightAnchor.constraint(equalToConstant: 43)
            
        ])
        
        users.forEach { b in
            b.widthAnchor.constraint(equalToConstant: 228).isActive = true
            b.heightAnchor.constraint(equalToConstant: 96).isActive = true
        }
        
        innerView.subviews.forEach {
            $0.centerXAnchor.constraint(equalTo: innerView .centerXAnchor).isActive = true
        }
        
        
    }

    
    func parentLayoutSetup() {
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        self.view.subviews.forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        //        frame: CGRect(x: 0, y: 0, width: 393, height: 671)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            innerView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            innerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 393),
            imageView.heightAnchor.constraint(equalToConstant: 671)
        ])
        
        
    }
}
