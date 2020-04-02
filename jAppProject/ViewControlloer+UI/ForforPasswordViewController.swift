//
//  ForforPasswordViewController.swift
//  jAppProject
//
//  Created by FRANK on 19/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit

extension ForgotPasswordViewController {

    func setupEmailTextFiels() {
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        emailContainerView.layer.cornerRadius = 3
        emailContainerView.clipsToBounds = true
        
        txtemail.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 178/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        txtemail.attributedPlaceholder = placeholderAttr
        txtemail.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    
    func setupResetButton() {
        
        btnReset.setTitle("RESET MY PASSWORD", for: UIControl.State.normal)
        btnReset.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnReset.backgroundColor = UIColor.black
        btnReset.layer.cornerRadius = 5
        btnReset.clipsToBounds = true
        btnReset.setTitleColor(.white, for: UIControl.State.normal)
    }

    
    
   

}
