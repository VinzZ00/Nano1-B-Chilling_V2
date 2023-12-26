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
    
    var nameField : UITextField {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text"
        return textField
    }
    
    var chillEmoticon : UILabel {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 24)
        l.text = "🥶"
        return l
    }
    
    var blueEmoticon : UILabel {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 24)
        l.text = "😕"
        return l
    }
    
    var stressEmoticon : UILabel {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 24)
        l.text = "🤯"
        return l
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    @objc func handleTapGest(_ sender : UITapGestureRecognizer) {
        if let label = sender.view as? UILabel
        {
            switch label.text! {
            case "🥶":
                emotions = Emotions(rawValue: label.text!)!
                blueEmoticon.gestureRecognizers?[0].isEnabled = false
                stressEmoticon.gestureRecognizers?[0].isEnabled = false
            case "😕":
                emotions = Emotions(rawValue: label.text!)!
                chillEmoticon.gestureRecognizers?[0].isEnabled = false
                stressEmoticon.gestureRecognizers?[0].isEnabled = false
            default :
                emotions = Emotions(rawValue: label.text!)!
                chillEmoticon.gestureRecognizers?[0].isEnabled = false
                blueEmoticon.gestureRecognizers?[0].isEnabled = false
            }
        }
    }
    
    func setup() {
        
        // Adding all into UIView
        addSubview(nameField)
        addSubview(chillEmoticon)
        addSubview(blueEmoticon)
        addSubview(stressEmoticon)
        
        // Remove Auto Layout
        self.subviews.forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Adding HandleTap to Button
//        let tapGest = UITapGestureRecognizer(target: self, action: #selector(handleTapGest))
//        
//        chillEmoticon.addGestureRecognizer(tapGest)
//        stressEmoticon.addGestureRecognizer(tapGest)
//        blueEmoticon.addGestureRecognizer(tapGest)
        
        // Setting Layout
        let safeAreaGuide = self.safeAreaLayoutGuide
        
//        NSLayoutConstraint.activate([
//            // Name Field
////            nameField.topAnchor.constraint(equalTo: self.topAnchor),
////            nameField.leftAnchor.constraint(equalTo: self.leftAnchor),
//            nameField.widthAnchor.constraint(equalToConstant: 228),
//            nameField.heightAnchor.constraint(equalToConstant: 34.73),
//            
//            //Emoticons
//            chillEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
//            chillEmoticon.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
//            
//            blueEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
//            blueEmoticon.leftAnchor.constraint(equalTo: chillEmoticon.rightAnchor, constant: 36),
//            
//            stressEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
//            stressEmoticon.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor)
//        
//        ])
        
        let constraints = [
                // Name Field
//                nameField.topAnchor.constraint(equalTo: self.topAnchor),
//                nameField.leftAnchor.constraint(equalTo: self.leftAnchor),
                nameField.widthAnchor.constraint(equalToConstant: 228),
                nameField.heightAnchor.constraint(equalToConstant: 34.73),
                
                // Emoticons
                chillEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
                chillEmoticon.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
                
                blueEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
                blueEmoticon.leftAnchor.constraint(equalTo: chillEmoticon.rightAnchor, constant: 36),
                
                stressEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
                stressEmoticon.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor)
            ]
            
            // Activate constraints
            NSLayoutConstraint.activate(constraints)
        
    }
}
