//
//  LoginViewController.swift
//  splitJar
//
//  Created by Robert Elizondo on 1/25/20.
//  Copyright © 2020 Robert Elizondo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var textout: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func loginPress(_ sender: Any) {
        
        textout.text = "User : \(emailField.text!)\nPass: \(passField.text!)\n"
        
        
    }
    


}

extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
