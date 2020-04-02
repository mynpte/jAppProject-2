//
//  SignUpViewController+UI.swift
//  jAppProject
//
//  Created by FRANK on 19/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit
import ProgressHUD

extension SignUpViewController {
    
    
    func setupTitleLable() {
        let title = "Sign UP"
        
        
        let attributedText = NSMutableAttributedString(string: title, attributes:
            [NSAttributedString.Key.font : UIFont.init(name: "Didot", size: 20)!,
             NSAttributedString.Key.foregroundColor : UIColor.black
            ])
        
        lbtitleText.attributedText = attributedText
    }
    
    func setupAvatar() {
        avatar.layer.cornerRadius = 40
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatar.addGestureRecognizer(tapGesture)
    }
    
    //เลือกรูปภาพ
    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }
   
    func setupFullnameTextField() {
        
        fullnameContainterView.layer.borderWidth = 1
        fullnameContainterView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        fullnameContainterView.layer.cornerRadius = 3
        fullnameContainterView.clipsToBounds = true
        
        txtfullname.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 178/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        txtfullname.attributedPlaceholder = placeholderAttr
        txtfullname.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    
    func setupEmailTextField() {
        emailContainterView.layer.borderWidth = 1
        emailContainterView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        emailContainterView.layer.cornerRadius = 3
        emailContainterView.clipsToBounds = true
        
        txtemil.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 178/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        txtemil.attributedPlaceholder = placeholderAttr
        txtemil.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    
    func setupPasswordTextField() {
        passwordContainterView.layer.borderWidth = 1
        passwordContainterView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        passwordContainterView.layer.cornerRadius = 3
        passwordContainterView.clipsToBounds = true
        
        txtpassword.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Password (8+ Characters)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 178/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        txtpassword.attributedPlaceholder = placeholderAttr
        txtpassword.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    func setupSignUpButton() {
        btnSignUp.setTitle("Sign Up", for: UIControl.State.normal)
        btnSignUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnSignUp.backgroundColor = UIColor.black
        btnSignUp.layer.cornerRadius = 5
        btnSignUp.clipsToBounds = true
        btnSignUp.setTitleColor(.white, for: UIControl.State.normal)
    }
   
    func setupSignInButton() {
        
        let attributedText = NSMutableAttributedString(string: "Already have account", attributes:
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)
        ])
        
        let attributedSubText = NSMutableAttributedString(string: "Sign In", attributes:
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),
             NSAttributedString.Key.foregroundColor : UIColor.black
               ])
               attributedText.append(attributedSubText)
        btnSingIn.setAttributedTitle(attributedText, for: UIControl.State.normal)
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func validateFields() {
        guard let username = self.txtfullname.text, !username.isEmpty else {
            ProgressHUD.showError("plese enter an username")
            return
        }
        guard let email = self.txtemil.text, !username.isEmpty else {
            ProgressHUD.showError("plese enter an email address")
            return
        }
        guard let password = self.txtpassword.text, !username.isEmpty else {
            ProgressHUD.showError("plese enter an password")
            return
        }
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

//รูปภาพ
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            avatar.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
            avatar.image = imageOriginal
        }
 
        picker.dismiss(animated: true, completion: nil)
    }
}
