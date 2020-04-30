//
//  createVC.swift
//  jAppProject
//
//  Created by FRANK on 27/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import ProgressHUD

class createVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let db = Firestore.firestore()
    let storage = Storage.storage()
    var userList:Dictionary = [String:[String:Any]]()
    var userName:Array = [String]()
    let imagePicker = UIImagePickerController()
    
    let Gender = ["Female","Male","Male & Female"]
    
    var pickerView = UIPickerView()
    
    
    var local = ""
/////////////////// btnlocation
//        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let svc = storyBoard.instantiateViewController(identifier: "navigation") as! UINavigationController
//        self.view.window?.rootViewController = svc
//////////////////////////



    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "creatVC" {
//            let vc = segue.destination as! createVC
//            vc.data = lbdate.text!
//        }
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(createVC.openGallery(tapGesture:)))
        imgevent.isUserInteractionEnabled = true
        imgevent.addGestureRecognizer(tapGesture)

        
        pickerView.dataSource = self
        pickerView.delegate = self

        createpicker()
        createDatePicker()
        createTimePicker()
        local = "\(local)"
        lblocation.text = "Select you location"
        lblocation.text = local
        txtlocation.text = local
    }
    
    @IBOutlet weak var imgevent: UIImageView!
    @IBOutlet weak var txttitle: UITextField!
    @IBOutlet weak var txtdescription: UITextField!
    @IBOutlet weak var btncreate: UIButton!
    @IBOutlet weak var txtphoto: UITextField!
    
    @IBOutlet weak var txtlocation: UITextField!
    
    
    @IBOutlet weak var lblocation: UILabel!
    
    
    
    //------------------ Date ------------//
    var pickerDate = UIDatePicker()
    @IBOutlet weak var txtDate: UITextField!
    func createDatePicker(){
        let toolbar1 = UIToolbar()
        toolbar1.sizeToFit()
        
        let doneD = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar1.setItems([doneD], animated: true)
        
        txtDate.inputAccessoryView = toolbar1
        txtDate.inputView = pickerDate
        pickerDate.datePickerMode = .date
        txtDate.textAlignment = .center
        txtDate.placeholder = "Select Date"
    }
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: pickerDate.date)
      
        txtDate.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
      //------------------ Date ------------//
    
    
    //------------------ Time ------------//
    @IBOutlet weak var txtTime: UITextField!
    var PickerTime = UIDatePicker()
    func createTimePicker(){
        let toolbar2 = UIToolbar()
        toolbar2.sizeToFit()
        
        let doneT = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donetime))
        toolbar2.setItems([doneT], animated: true)
        
        txtTime.inputAccessoryView = toolbar2
        txtTime.inputView = PickerTime
        PickerTime.datePickerMode = .time
        txtTime.textAlignment = .center
        txtTime.placeholder = "Select Time"
    }
    
    @objc func donetime(){
        let formatter = DateFormatter()
         formatter.dateStyle = .none
         formatter.timeStyle = .short
         
        let timeString = formatter.string(from: PickerTime.date)
      
        txtTime.text = "\(timeString)"
        self.view.endEditing(true)
    }
    //------------------ Time ------------//
    
    
    //------------------- Gender ----------------------------------//
    @IBOutlet weak var txtgender: UITextField!
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Gender[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtgender.text = Gender[row]
    }
    //        txtgender.resignFirstResponder() เลือกเเล้วโชว์เลย
    
    func createpicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let btndone = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done))
        toolbar.setItems([btndone], animated: true)
        
        txtgender.inputAccessoryView = toolbar
        txtgender.inputView = pickerView
        
        txtgender.textAlignment = .center
        txtgender.placeholder = "Select Gender"
    }
    @objc func done() {
        txtgender.resignFirstResponder()
        self.view.endEditing(true)
    }
    //------------------- Gender ----------------------------------//


    @IBAction func btncreate(_ sender: Any) {
    
        self.uploadImage(_image: self.imgevent.image!){ url in
            self.add(title: "\(self.txttitle.text!)", description:"\(self.txtdescription.text!)", date:"\(self.txtDate.text!)", time:"\(self.txtTime.text!)", gender:"\(self.txtgender.text!)", photo: "\(self.txtphoto.text!)" ,location: "\(self.lblocation.text!)", ProfileURL: url!){ success in
                       if success != nil{
                           print("yeah yes")
                           
                       }else {
                        print("try again")
                }
                       
                   }
           
            }
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func openGallery(tapGesture: UITapGestureRecognizer){
        self.setupImagePicker()
    }
    
    func add(title:String, description:String, date:String, time:String, gender:String, photo:String, location:String, ProfileURL:URL, complesion: @escaping(_ url:URL?) ->()){
    self.db.collection("create").document(title).setData([
            "title" : title,
            "description" : description,
            "date": date,
            "time": time,
            "gender": gender,
            "photo" : "\(title).jpg",
            "location" : location,
            "profileUrl" : ProfileURL.absoluteString
        
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: ")
                self.readDB()
            }
            
        }
    }
    
    func readDB() {

    self.db.collection("create").getDocuments { (DocumentSnapshot, Error) in
       if Error == nil && DocumentSnapshot != nil {
           self.userList.removeAll()
           self.userName.removeAll()

           for document in DocumentSnapshot!.documents {

               let data = document.data()
               let name = data["title"] as! String

               self.userList[name] = data
               self.userName.append(name)
           
           }

           print("success leaw jaaaaa")
       } 
        
       }
        
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                      let mvc = self.storyboard?.instantiateViewController(identifier: "homeVC") as! HomeViewController
                      self.view.window?.rootViewController = mvc
        }

}

extension createVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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
        imgevent.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension createVC{

func uploadImage(_image:UIImage, completion: @escaping((_ url:URL?) ->())){
    let storageRef = Storage.storage().reference().child("\(txttitle.text!).jpg")
    let imgData = imgevent.image?.pngData()
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


