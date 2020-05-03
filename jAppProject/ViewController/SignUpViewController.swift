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

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

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
    @IBOutlet weak var txtphoto: UITextField!
    
    var image: UIImage? = nil
    let imagePicker = UIImagePickerController()
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(SignUpViewController.openGallery(tapGesture:)))
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(tapGesture)

        
        pickerView.dataSource = self
        pickerView.delegate = self
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    
    @IBAction func btnSignUpDidTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.validateFields()
        
//        guard let imageSelected = self.image else {
//            ProgressHUD.showError("plese choose your profile image")
//            return
//        }
//
//        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
//            return
//        }
        
        Auth.auth().createUser(withEmail: txtemil.text!, password: txtpassword.text!) { authResult, error in
           if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                          }
                        else {
            self.uploadImage(_image: self.avatar.image!){ url in
                self.add(fullname:"\(self.txtfullname.text!)", email: "\(self.txtemil.text!)", photo: "\(self.txtphoto.text)", ProfileURL: url!){ success in
                        if success != nil{
                            print("yeah yes")
                            
                        }else {
                         print("try again")
                 }
                        
                    }
            
             }

             }
        }

    }
    
    @objc func openGallery(tapGesture: UITapGestureRecognizer){
        self.setupImagePicker()
    }
    
    func add(fullname:String, email:String, photo:String, ProfileURL:URL, complesion: @escaping(_ url:URL?) ->()){
    self.db.collection("user2").document(email).setData([
            "fullname" : fullname,
            "email" : email,
            "photo" : "\(fullname).jpg",
            "profileUrl" : ProfileURL.absoluteString
        
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: ")
//                self.readData()
                
                print("Sign UP Successfully")
                    let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let mvc = self.storyboard?.instantiateViewController(identifier: "homeVC") as! HomeViewController
                    self.view.window?.rootViewController = mvc
            }
            
        }
    }
    
    
   func readData() {
    self.db.collection("user2").getDocuments { (DocumentSnapshot, Error) in
       if Error == nil && DocumentSnapshot != nil {
           self.userList.removeAll()
           self.userName.removeAll()

           for document in DocumentSnapshot!.documents {

               let data = document.data()
               let name = data["email"] as! String

               self.userList[name] = data
               self.userName.append(name)
           
           }

           print("Sign UP Successfully")
       }
        
       }
        
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = self.storyboard?.instantiateViewController(identifier: "homeVC") as! HomeViewController
        self.view.window?.rootViewController = mvc
        }
  
}


extension SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func setupImagePicker(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.isEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        avatar.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpViewController{

func uploadImage(_image:UIImage, completion: @escaping((_ url:URL?) ->())){
    let storageRef = Storage.storage().reference().child("\(txtfullname.text!).jpg")
    let imgData = avatar.image?.pngData()
    let metaData = StorageMetadata()
    metaData.contentType = "image/png"
    storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
        if error == nil{
            print("success img")
            storageRef.downloadURL(completion: { (url, error) in
                completion(url)
            })
        }else{
            print("error in save image")
            completion(nil)
        }
        }
    }
    
}



//        if txtemil.text != nil && txtpassword != nil {
//            Auth.auth().createUser(withEmail: txtemil.text!, password: txtpassword.text!) {
//                (Result, Error) in
//                if Error != nil {
//                    ProgressHUD.showError(Error!.localizedDescription)
//                }
//                else {
//
//                    let db = Firestore.firestore()
//
//                        let storageRef = Storage.storage().reference(forURL: "gs://joinappproject-f1de0.appspot.com")
//
//                        let storageProfilRef = storageRef.child("\(self.txtfullname.text!).jpg")
//
//                        let metadata = StorageMetadata()
//                        metadata.contentType = "image/jpg"
//                        storageProfilRef.putData(imageData, metadata: metadata, completion: {(StorageMetadata, error) in
//                            if error != nil {
//                                print(error?.localizedDescription)
//                                return
//                            }
//
//                            storageProfilRef.downloadURL { (url, error) in
//                                if let metaImageUrl = url?.absoluteString {
////                                    print(metaImageUrl)
//
//
//                                    db.collection("user2").addDocument(data: ["fullname":self.txtfullname.text!, "Image" : "\(self.txtfullname.text!).jpg", "uid": Result!.user.uid])
//                                }
//                            }
//
//                        } )
//
//                    Alert.alertsigUpsuccessfully(on: self)
//                    print("Register Successfully")
//                    self.dismiss(animated: true, completion: nil)
//
//
//
//                }
//            }
//        }
