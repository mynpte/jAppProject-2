//
//  SignUpViewController.swift
//  jAppProject
//
//  Created by FRANK on 19/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var lbtitleText: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullnameContainterView: UIView!
    @IBOutlet weak var txtfullname: UITextField!
    @IBOutlet weak var emailContainterView: UIView!
    @IBOutlet weak var txtemil: UITextField!
    @IBOutlet weak var passwordContainterView: UIView!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnSingIn: UIButton!
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }
    
    func setupUI() {
        
        setupTitleLable()
        setupAvatar()
        setupFullnameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupSignInButton()
        
    }
    
    var userList:Dictionary = [String:[String:Any]]()
    var userName:Array = [String]()
    
    let  db = Firestore.firestore()
    let storage = Storage.storage()
    
    @IBAction func dismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnSignUpDidTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.validateFields()
        
        guard let imageSelected = self.image else {
            ProgressHUD.showError("plese choose your profile image")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
        }
        if txtemil.text != nil && txtpassword != nil {
            Auth.auth().createUser(withEmail: txtemil.text!, password: txtpassword.text!) {
                (Result, Error) in
                if Error != nil {
                    ProgressHUD.showError(Error!.localizedDescription)
                }
                else {
                   
                    let db = Firestore.firestore()
                
                        let storageRef = Storage.storage().reference(forURL: "gs://joinappproject-f1de0.appspot.com")
                    
                        let storageProfilRef = storageRef.child("\(self.txtfullname.text!).jpg")
                        
                        let metadata = StorageMetadata()
                        metadata.contentType = "image/jpg"
                        storageProfilRef.putData(imageData, metadata: metadata, completion: {(StorageMetadata, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                                return
                            }
                            
                            storageProfilRef.downloadURL { (url, error) in
                                if let metaImageUrl = url?.absoluteString {
//                                    print(metaImageUrl)
                                    
                         
                                    db.collection("user2").addDocument(data: ["fullname":self.txtfullname.text!, "Image" : "\(self.txtfullname.text!).jpg", "uid": Result!.user.uid])
                                }
                            }
                            
                        } )
                   
                    Alert.alertsigUpsuccessfully(on: self)
                    print("Register Successfully")
                    self.dismiss(animated: true, completion: nil)
                    
//                    let storyBord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                       let mvc = self.storyboard?.instantiateViewController(identifier: "homeVC") as! HomeViewController
//
//                    mvc.modalTransitionStyle = .crossDissolve
//
//                    self.present(mvc, animated: true, completion: nil)
//
//                    mvc.userList = self.userList
//                    mvc.userName = self.userName
//
//                       if self.userList.count > 0 {
//                           self.view.window?.rootViewController = mvc
//                       }
//                       else {
//                           self.btnSignUpDidTapped(self.btnSignUp as Any)
//                       }
                }
            }
        }
    }
    
}
