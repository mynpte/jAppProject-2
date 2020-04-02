//
//  SignInViewController+UI.swift
//  jAppProject
//
//  Created by FRANK on 19/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit

extension SignInViewController {
    
    func setupTitleLable() {
         let title = "Sign In"
         
         
         let attributedText = NSMutableAttributedString(string: title, attributes:
             [NSAttributedString.Key.font : UIFont.init(name: "Didot", size: 20)!,
              NSAttributedString.Key.foregroundColor : UIColor.black
             ])
         
         lbtitleText.attributedText = attributedText
     }
     
     
     func setupEmailTextField() {
         emailContainerView.layer.borderWidth = 1
         emailContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
         emailContainerView.layer.cornerRadius = 3
         emailContainerView.clipsToBounds = true
         
         txtEmail.borderStyle = .none
         
         let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 178/255, green: 170/255, blue: 170/255, alpha: 1)])
         
         txtEmail.attributedPlaceholder = placeholderAttr
         txtEmail.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
     }
     
     func setupPasswordTextField() {
         passwordContainerView.layer.borderWidth = 1
         passwordContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
         passwordContainerView.layer.cornerRadius = 3
         passwordContainerView.clipsToBounds = true
         
         txtPassword.borderStyle = .none
         
         let placeholderAttr = NSAttributedString(string: "Password (8+ Characters)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 178/255, green: 170/255, blue: 170/255, alpha: 1)])
         
         txtPassword.attributedPlaceholder = placeholderAttr
         txtPassword.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
         
     }
     func setupSignUpButton() {
         let attributedText = NSMutableAttributedString(string: "Don't have an account", attributes:
             [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
              NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)
         ])
         
         let attributedSubText = NSMutableAttributedString(string: "Sign Up", attributes:
             [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),
              NSAttributedString.Key.foregroundColor : UIColor.black
                ])
                attributedText.append(attributedSubText)
        btnSignUp.setAttributedTitle(attributedText, for: UIControl.State.normal)
     }
    
     func setupSignInButton() {
    
        btnSignIn.setTitle("Sign In", for: UIControl.State.normal)
        btnSignIn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnSignIn.backgroundColor = UIColor.black
        btnSignIn.layer.cornerRadius = 5
        btnSignIn.clipsToBounds = true
        btnSignIn.setTitleColor(.white, for: UIControl.State.normal)
         
       
     }
    
    func readData(){
        db.collection("commu2").getDocuments { (DocumentSnapshot, Error) in

        if Error == nil && DocumentSnapshot != nil {

            for document in DocumentSnapshot!.documents {

                let data = document.data()
                let name = data["fullname"] as! String
                    
                self.userList[name] = data
                self.userName.append(name)
                                        
                }
            }
        }
    }
    
}
