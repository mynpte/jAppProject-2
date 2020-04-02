//
//  detailVC.swift
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

class detailVC: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showData()
    }
    
    let storage = Storage.storage()
       let db = Firestore.firestore()
       var userList:Dictionary = [String:[String:Any]]()
       var userName:Array = [String]()
       var num:Int = 0
    
    @IBOutlet weak var imgphoto: UIImageView!
    @IBOutlet weak var lbtitle: UILabel!
    @IBOutlet weak var lbdescrip: UILabel!
    @IBOutlet weak var lbsex: UILabel!
    @IBOutlet weak var lblocation: UILabel!
    @IBOutlet weak var lbage: UILabel!
    @IBOutlet weak var lbdate: UILabel!
    @IBOutlet weak var lbtime: UILabel!
    
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(identifier: "homeVC") as! HomeViewController
            self.view.window?.rootViewController = vc
//        navigationController?.popViewController(animated: true)
    }
    
    
    func showData() {
        
        let storageRef = storage.reference().child(userList[userName[num]]!["photo"] as! String)
        
        let downloadTask = storageRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
            if let error = error {
                print("Download Error!\(error)")
            } else {
                let image = UIImage(data: data!)
                self.imgphoto.image = image
            }
        }
        
        self.lbtitle.text = userList[userName[num]]!["title"] as! String
        self.lbdescrip.text = userList[userName[num]]!["description"] as! String
//        self.lbage.text = userList[userName[num]]!["age"] as! String
//        self.lblocation.text = userList[userName[num]]!["location"] as! String
        self.lbdate.text = userList[userName[num]]!["date"] as! String
        self.lbtime.text = userList[userName[num]]!["time"] as! String
        self.lbsex.text = userList[userName[num]]!["gender"] as! String
        
        
    }
    

}
