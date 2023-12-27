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
    
    var chillEmoticon : UILabel!
    
    var blueEmoticon : UILabel!
    
    var stressEmoticon : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 24)
        l.text = "🤯"
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
    
    @objc func handleTapGest() {
        print("tapped")
    }

    
    func setup() {
        
        chillEmoticon = UILabel()
        chillEmoticon.textAlignment = .center
        chillEmoticon.font = UIFont.systemFont(ofSize: 24)
        chillEmoticon.text = "🥶"
        chillEmoticon.isUserInteractionEnabled = true
        
        blueEmoticon = UILabel()
        blueEmoticon.textAlignment = .center
        blueEmoticon.font = UIFont.systemFont(ofSize: 24)
        blueEmoticon.text = "😕"
        blueEmoticon.isUserInteractionEnabled = true
        
//        let stressEmoticon = self.stressEmoticon
        stressEmoticon.isUserInteractionEnabled = true
        
        
        // Adding all into UIView
        addSubview(nameField)
        addSubview(chillEmoticon)
        addSubview(blueEmoticon)
        addSubview(stressEmoticon)

        let tapGest = UITapGestureRecognizer(target: self, action: #selector(handleTapGest))
        
//        blueEmoticon.addGestureRecognizer(tapGest)
        stressEmoticon.addGestureRecognizer(tapGest)
//        chillEmoticon.addGestureRecognizer(tapGest)
        
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
