//
//  SignInViewController.swift
//  jAppProject
//
//  Created by FRANK on 19/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import ProgressHUD

public var auth = Auth.auth()


class SignInViewController: UIViewController {
    
    var userList:Dictionary = [String:[String:Any]]()
    var userName:Array = [String]()
    
    @IBOutlet weak var lbtitleText: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
       
    
    override func viewDidLoad() {
        super.viewDidLoad()

    setUpUI()
    readData()
               // Do any additional setup after loading the view.
           }
           
    func setUpUI() {
        setupTitleLable()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupSignInButton()
        
    }
    
    
    
    let  db = Firestore.firestore()
    let storage = Storage.storage()
    
    
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        DispatchQueue.main.async {
                   print("Signing in...")
                   
                   if self.txtEmail.text != nil && self.txtPassword != nil {
                       Auth.auth().signIn(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (user,error) in
                           if error != nil {
                               print(error.debugDescription)
                            ProgressHUD.showError("Please check for accuracy")
                            
                           }
                           else {
                               print("Login Successfully")
                               
                               let storyBord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                               let mvc = self.storyboard?.instantiateViewController(identifier: "homeVC") as! HomeViewController
                            
                            mvc.modalTransitionStyle = .crossDissolve

                          
                               
                            mvc.userList = self.userList
                            mvc.userName = self.userName
                            
//                            self.present(mvc, animated: true, completion: nil)
                               
//                               if self.userList.count > 0 {
                            self.view.window?.rootViewController = mvc
//                               }
//                               else {
//                                   self.btnSignIn(self.btnSignIn as Any)
//                               }
                           }
                       }
                   }
               }
          }
    
    @IBAction func dismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
