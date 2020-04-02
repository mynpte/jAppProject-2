//
//  HomeViewController.swift
//  jAppProject
//
//  Created by FRANK on 26/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let storage = Storage.storage()
    let db = Firestore.firestore()
    var userList:Dictionary = [String:[String:Any]]()
    var userName:Array = [String]()
    var num:Int = 0


    @IBOutlet weak var lognInForUser: UILabel!
    

//        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//           let svc = storyBoard.instantiateViewController(identifier: "createVC") as! createVC
//            self.view.window?.rootViewController = svc

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        readData()
         print(self.userList)
         
         let bounds  = feedVC.bounds
         let collectionViewLayout =  feedVC?.collectionViewLayout as! UICollectionViewFlowLayout
        
         collectionViewLayout.estimatedItemSize = CGSize(width: bounds.width/1 - 10, height: 250)
         collectionViewLayout.sectionInset = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
         
         feedVC.delegate = self
        feedVC.dataSource = self as! UICollectionViewDataSource
         feedVC.backgroundColor = UIColor.yellow.withAlphaComponent(0)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.lognInForUser.text = "Hello ," + (Auth.auth().currentUser?.email)!
        }
        else {
            self.lognInForUser.text = "Please Login"
        }
        
    }
    
    @IBOutlet weak var feedVC: UICollectionView!
    
    @IBAction func logOut(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let svc = storyBoard.instantiateViewController(identifier: "signinVC") as! SignInViewController
         self.view.window?.rootViewController = svc
//          self.dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
        print("log out success")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! feedVC
        
        let storageRef = storage.reference().child(userList[userName[indexPath.row]]!["photo"] as! String)
        
        let downloadTask = storageRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
            if let error = error {
                print("Download Error!\(error)")
            } else {
                let image = UIImage(data: data!)
                cell.imgevent.image = image
            }
        }
        
        
        cell.lbname.text = userList[userName[indexPath.row]]!["title"] as! String
        cell.scrip.text = userList[userName[indexPath.row]]!["description"] as! String
        cell.index = indexPath
        
        return cell
    }
    
    func readData(){
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
               self.recollec()
               self.feedVC.reloadData()
               print("reload")
               }
           }
       }
    
    func recollec(){
        let bounds  = feedVC.bounds
        let collectionViewLayout =  feedVC?.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewLayout.estimatedItemSize = CGSize(width: bounds.width/1 - 10, height: 300)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 5,left: 5,bottom: 0,right: 5)
        
        feedVC.delegate = self
        feedVC.dataSource = self
        
    }
    
    
    @IBAction func viewDatail(_ sender: Any) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
             print("index path of read: \(indexPath.row)")
             print(self.userList[self.userName[indexPath.row]])
             
             self.num = indexPath.row
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //        let mvc = self.storyboard?.instantiateViewController(identifier: "detailView") as! detailVC
            
            let mvc = self.storyboard?.instantiateViewController(identifier: "detailView") as! detailVC
            
            
            mvc.userList = self.userList
            mvc.userName = self.userName
            mvc.num = self.num
            
            if self.userList.count > 0 {
               self.view.window?.rootViewController = mvc
           }
            
            
        }
       
       
    

}
