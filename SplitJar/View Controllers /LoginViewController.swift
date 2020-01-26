//
//  LoginViewController.swift
//  splitJar
//
//  Created by Robert Elizondo on 1/25/20.
//  Copyright © 2020 Robert Elizondo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet var _email: UITextField!
    
    @IBOutlet var _pass: UITextField!
    
    @IBOutlet var _login_button: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        _email.delegate = self
        _pass.delegate = self
        
   
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        
        
        let email = _email.text
        let pass = _pass.text
        
        if(email == "" || pass == ""){
            return
        }
        
        DoLogin(email!, pass!)
        
    }
    
    func DoLogin(_ user:String, _ psw:String)
    {
        let url = URL(string: "http://192.168.1.5:3000/api/v1/users")
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
        (data, response, error) in
            
            guard let _:Data = data else
            {
                return
            }
            
            let json:Any?
            
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch
            {
                return
            }
            
            
            guard let server_response = json as? NSDictionary else
            {
                return
            }
            
            
            if let data_block = server_response["data"] as? NSDictionary
            {
                if let session_data = data_block["session"] as? String
                {
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    
                    DispatchQueue.main.async (
                        execute:self.LoginDone
                    )
                }
            }
        
        })
        
        task.resume()
    }
    
    
    func LoginToDo()
    {
        _email.isEnabled = true
        _pass.isEnabled = true
        
        _login_button.setTitle("Login", for: .normal)
    }
    
    func LoginDone()
    {
        _email.isEnabled = false
        _pass.isEnabled = false
        
        _login_button.setTitle("Logout", for: .normal)
    }




}


extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

