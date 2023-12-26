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
    
    var users : [CustomFormCell] = {
//        CGRect(x: 0, y: 0, width: 228, height: 96)
        let firstPersonForm : CustomFormCell = CustomFormCell()
        let secondPersonForm : CustomFormCell = CustomFormCell()
        let thirdPersonForm : CustomFormCell = CustomFormCell()
        return [firstPersonForm, secondPersonForm, thirdPersonForm]
    }()
    
    @objc func tapLogo() {
        print("Logo Had been tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapgest = UITapGestureRecognizer(target: self, action: #selector(tapLogo))
        
        view.backgroundColor = .white
        imageView = UIImageView(image: LogoImage)
        imageView.addGestureRecognizer(tapgest)
        
        
        
        innerView = UIView()
        innerView.layer.cornerRadius = 43
        innerView.backgroundColor = commonColor

        TextDescription = UILabel()
        TextDescription?.text = "Please list your chill friends bellow,"
        TextDescription.textColor = .white
        
//        users.forEach({ formCell in
//            innerView.addSubview(formCell)
//        })
        
        users[0].isUserInteractionEnabled = true
        
        exploreButton = UIButton(type: .system)
        exploreButton.setTitle("Explore", for: .normal)
        exploreButton.setTitleColor(commonColor, for: .normal)
        exploreButton.backgroundColor = .white
        
        self.view.addSubview(imageView)
//        
        innerView.addSubview(TextDescription)
        innerView.addSubview(users[0])
//        innerView.addSubview(exploreButton)
//
//
        innerLayoutSetup()
//        
        self.view.addSubview(innerView)
//        
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
            
            users[0].leadingAnchor.constraint(equalTo: innerView.leadingAnchor, constant: 20)
//            users[0].topAnchor.constraint(equalTo: TextDescription.bottomAnchor, constant: 33),
//
//            users[1].topAnchor.constraint(equalTo: users[0].topAnchor, constant: 11),
//            
//            users[2].topAnchor.constraint(equalTo: users[1].topAnchor, constant: 11),
//
//            exploreButton.topAnchor.constraint(equalTo: users[2].bottomAnchor, constant: 71),
//            exploreButton.widthAnchor.constraint(equalToConstant: 151),
//            exploreButton.heightAnchor.constraint(equalToConstant: 43)
//            
        ])
//        
//        users.forEach { b in
//            b.widthAnchor.constraint(equalToConstant: 228).isActive = true
//            b.heightAnchor.constraint(equalToConstant: 96).isActive = true
//        }
//        
//        innerView.subviews.forEach {
//            $0.centerXAnchor.constraint(equalTo: innerView .centerXAnchor).isActive = true
//        }
//        
        
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
            innerView.widthAnchor.constraint(equalToConstant: 393),
            innerView.heightAnchor.constraint(equalToConstant: 671)
        ])
        
        
    }
}
