//
//  Alert.swift
//  jAppProject
//
//  Created by FRANK on 27/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
  private static func showAlert(on vc: UIViewController, with  title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
    
    DispatchQueue.main.async {
         vc.present(alert, animated: true)
        
    }
       
    }
    
    static func alertsigUpsuccessfully(on vc: UIViewController) {
        showAlert(on: vc, with: "Register Successfully", message: "welcom to j_App")
        
    }
}

