//
//  ViewController+UI.swift
//  jAppProject
//
//  Created by FRANK on 19/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit

extension ViewController {
    
     func setupHeaderTitle() {
         let title = "Create a new account"
         let subTitle = "\n\nLorem ipsum dolor sit amet conse ctetur adipisicing elis sed do."
         
         let attributedText = NSMutableAttributedString(string: title, attributes:
             [NSAttributedString.Key.font : UIFont.init(name: "Didot", size: 20)!,
              NSAttributedString.Key.foregroundColor : UIColor.black
             ])
         let attributedSubTitle = NSMutableAttributedString(string: subTitle, attributes:
             [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
              NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.45)
         ])
         attributedText.append(attributedSubTitle)
         
         let paragrapStyle = NSMutableParagraphStyle()
         paragrapStyle.lineSpacing = 5

         attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragrapStyle, range: NSMakeRange(0, attributedText.length))
         
         lbTitle.numberOfLines = 0
         
         lbTitle.attributedText = attributedText
     }
    
    func setupOrLabel() {
        
        lbOr.text = "Or"
        lbOr.font = UIFont.boldSystemFont(ofSize: 16)
        lbOr.textColor = UIColor(white: 0, alpha: 0.45)
        lbOr.textAlignment = .center
    }
    
    func setupTermsLabel() {
        let attributedTermsText = NSMutableAttributedString(string: "By clicking Create a new account you agree to our", attributes:
                   [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)
               ])
               
               let attributedSubTermsText = NSMutableAttributedString(string: "Terms of Service", attributes:
                   [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                    NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)
                      ])
                      attributedTermsText.append(attributedSubTermsText)
               
               lbtermsOfService.attributedText = attributedTermsText
               lbtermsOfService.numberOfLines = 0
               
    }
    
    func setupFacbppkButton() {
        btnSignInFacebook.setTitle("Sign in with Facebook", for: UIControl.State.normal)
        btnSignInFacebook.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnSignInFacebook.backgroundColor = UIColor(red: 58/255, green: 85/255, blue: 159/255, alpha: 1)
        btnSignInFacebook.layer.cornerRadius = 5
        btnSignInFacebook.clipsToBounds = true
        
        btnSignInFacebook.setImage(UIImage(named:"facebook"), for: UIControl.State.normal)
        btnSignInFacebook.imageView?.contentMode = .scaleToFill
        btnSignInFacebook.tintColor = .white
        btnSignInFacebook.imageEdgeInsets = UIEdgeInsets(top: 12, left: -15, bottom: 12, right: 0)
    }
    
    func setupGoogleButton() {
        btnSignInGoogle.setTitle("Sign in with Google", for: UIControl.State.normal)
        btnSignInGoogle.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnSignInGoogle.backgroundColor = UIColor(red: 223/255, green: 74/255, blue: 58/255, alpha: 1)
        btnSignInGoogle.layer.cornerRadius = 5
        btnSignInGoogle.clipsToBounds = true
        
        btnSignInGoogle.setImage(UIImage(named:"icons-google"), for: UIControl.State.normal)
        btnSignInGoogle.imageView?.contentMode = .scaleToFill
        btnSignInGoogle.tintColor = .white
        btnSignInGoogle.imageEdgeInsets = UIEdgeInsets(top: 12, left: -35, bottom: 12, right: 0)
    }
    
    func setupCreateAccountButton() {
        btnSignIncreateAccount.setTitle("Create a new account", for: UIControl.State.normal)
               btnSignIncreateAccount.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
               btnSignIncreateAccount.backgroundColor = UIColor.black
               btnSignIncreateAccount.layer.cornerRadius = 5
               btnSignIncreateAccount.clipsToBounds = true
    }

}
