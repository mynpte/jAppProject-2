//
//  ViewController.swift
//  jAppProject
//
//  Created by FRANK on 19/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnSignInFacebook: UIButton!
    @IBOutlet weak var btnSignInGoogle: UIButton!
    @IBOutlet weak var lbOr: UILabel!
    @IBOutlet weak var btnSignIncreateAccount: UIButton!
    @IBOutlet weak var lbtermsOfService: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        setupHeaderTitle()
        setupOrLabel()
        setupTermsLabel()
        setupFacbppkButton()
        setupGoogleButton()
        setupCreateAccountButton()
       
    }


}

