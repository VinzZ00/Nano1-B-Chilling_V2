//
//  CustomFormCell.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 25/12/23.
//

import UIKit

class CustomFormCell: UIView {

    var name : String = ""
    var emotions : Emotions = .chill
    
    var nameField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 19
        
        textField.placeholder = "Enter text"
        return textField
    }()
    
    var chillEmoticon : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 24)
        l.text = "🥶"
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(handleTapGest(_:)))
        l.addGestureRecognizer(tapGest)
        return l
    }()
    
    var blueEmoticon : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 24)
        l.text = "😕"
        l.isUserInteractionEnabled = true
        return l
    }()
    
    var stressEmoticon : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 24)
        l.text = "🤯"
        l.isUserInteractionEnabled = true
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    @objc func handleTapGest(_ sender : UITapGestureRecognizer) {
//        if let label = sender.view as? UILabel
//        {
//            switch label.text! {
//            case "🥶":
//                print("Chill")
//                emotions = Emotions(rawValue: label.text!)!
//                blueEmoticon.gestureRecognizers?[0].isEnabled = false
//                stressEmoticon.gestureRecognizers?[0].isEnabled = false
//            case "😕":
//                print("blue")
//                emotions = Emotions(rawValue: label.text!)!
//                chillEmoticon.gestureRecognizers?[0].isEnabled = false
//                stressEmoticon.gestureRecognizers?[0].isEnabled = false
//            default :
//                print("default")
//                emotions = Emotions(rawValue: label.text!)!
//                chillEmoticon.gestureRecognizers?[0].isEnabled = false
//                blueEmoticon.gestureRecognizers?[0].isEnabled = false
//            }
//        }
        
        print("tapped")
    }
    
    func setup() {
        // Remove Auto Layout
        
        
        // Adding HandleTap to Button
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(handleTapGest(_:)))
        
        chillEmoticon.addGestureRecognizer(tapGest)
//        stressEmoticon.addGestureRecognizer(tapGest)
//        blueEmoticon.addGestureRecognizer(tapGest)

        chillEmoticon.isUserInteractionEnabled = true
//        stressEmoticon.isUserInteractionEnabled = true
//        blueEmoticon.isUserInteractionEnabled = true
        
        self.isUserInteractionEnabled = true
        
        // Adding all into UIView
        addSubview(nameField)
        addSubview(chillEmoticon)
        addSubview(blueEmoticon)
        addSubview(stressEmoticon)
        
        self.subviews.forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Setting Layout
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // Name Field
            nameField.topAnchor.constraint(equalTo: self.topAnchor),
            nameField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameField.widthAnchor.constraint(equalToConstant: 228),
            nameField.heightAnchor.constraint(equalToConstant: 34.73),
            
            //Emoticons
            chillEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
            chillEmoticon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            chillEmoticon.heightAnchor.constraint(equalToConstant: 200),
//
            blueEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
            blueEmoticon.leadingAnchor.constraint(equalTo: chillEmoticon.trailingAnchor, constant: 36),
//
            stressEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
            stressEmoticon.leadingAnchor.constraint(equalTo: blueEmoticon.trailingAnchor, constant: 36),
            
        ])
        
        
        
    }
}
