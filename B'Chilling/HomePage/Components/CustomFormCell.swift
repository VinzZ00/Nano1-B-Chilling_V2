//
//  CustomFormCell.swift
//  B'Chilling
//
//  Created by Elvin Sestomi on 25/12/23.
//

import UIKit

class CustomFormCell: UIView, UITextFieldDelegate {

    var name : String = ""
    var emotion : Emotions = .chill
    
    var nameField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.5
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 19
        textField.placeholder = "Enter text"
        return textField
    }()
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let t = textField.text {
            name = t
        }
    }
    
    let chillEmoticon : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 24)
        l.text = "🥶"
        l.isUserInteractionEnabled = true
        return l
    }()
    
    let blueEmoticon : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 24)
        l.text = "😕"
        l.isUserInteractionEnabled = true
        return l
    }()
    
    let stressEmoticon : UILabel = {
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
    
    @objc func handleTapGest(_ sender : UIGestureRecognizer) {
        print("tapped")
        
        if let label = sender.view as? UILabel
        {
            switch label.text! {
            case "🥶":
                print("chill")
                chillEmoticon.alpha = 1
                blueEmoticon.alpha = 0.5
                stressEmoticon.alpha = 0.5
                emotion = Emotions(rawValue: label.text!)!

            case "😕":
                print("blue")
                chillEmoticon.alpha = 0.5
                blueEmoticon.alpha = 1
                stressEmoticon.alpha = 0.5
                emotion = Emotions(rawValue: label.text!)!

            default :
                print("Stress")
                chillEmoticon.alpha = 0.5
                blueEmoticon.alpha = 0.5
                stressEmoticon.alpha = 1
                emotion = Emotions(rawValue: label.text!)!

            }
        }
    }

    
    func setup() {
        
        // Adding all into UIView
        addSubview(nameField)
        addSubview(chillEmoticon)
        addSubview(blueEmoticon)
        addSubview(stressEmoticon)

        
        //Create Tap Gessture
        let chillTapGest = UITapGestureRecognizer(target: self, action: #selector(handleTapGest))
        let blueTapGest = UITapGestureRecognizer(target: self, action: #selector(handleTapGest))
        let stressTapGest = UITapGestureRecognizer(target: self, action: #selector(handleTapGest))
        
        //Register Tap Gesture
        chillEmoticon.addGestureRecognizer(chillTapGest)
        blueEmoticon.addGestureRecognizer(blueTapGest)
        stressEmoticon.addGestureRecognizer(stressTapGest)
        
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
            
            blueEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
            blueEmoticon.leadingAnchor.constraint(equalTo: chillEmoticon.trailingAnchor, constant: 36),

            stressEmoticon.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 11.27),
            stressEmoticon.leadingAnchor.constraint(equalTo: blueEmoticon.trailingAnchor, constant: 36),
            
        ])
        
        
        
    }
}
