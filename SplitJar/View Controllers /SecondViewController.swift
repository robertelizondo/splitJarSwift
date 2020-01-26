//
//  SecondViewController.swift
//  splitJar
//
//  Created by Robert Elizondo on 1/25/20.
//  Copyright © 2020 Robert Elizondo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    //let st:LoginViewController = LoginViewController()
    
    var name = String()
    
    var email = String()
    
    var balance = Double()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    @IBOutlet var nameLable: UILabel!
    
    @IBOutlet var emailLable: UILabel!
    
    @IBOutlet var balanceLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLable.text = name
        
        emailLable.text = email
        
        balanceLable.text = "$"+String(balance)
        
        
        // Do any additional setup after loading the view.
    }
    
    
}

