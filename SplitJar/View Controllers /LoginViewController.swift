//
//  LoginViewController.swift
//  splitJar
//
//  Created by Robert Elizondo on 1/25/20.
//  Copyright © 2020 Robert Elizondo. All rights reserved.
//

import UIKit

import Foundation

class LoginViewController: UIViewController {

    struct jUser: Codable {
        let email: String?
        let name: String?
        let password: String?
        let balance: Double?
    }
    
    struct jUserRespose: Codable{
        let message: String?
        let user: jUser?
    }
    
    
    struct jJar: Codable {
        let title: String?
        let description: String?
        let balance: Double?
        let charge: Double?
        let goal: Double?
        let users: [String]?
    }
    
    
    struct jJarResponse: Codable {
        let message: String?
        //Array of Jars
        let jars: [jJar]?
    }
    
    
    
    
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
    

    var uFound = false;
    
    var gbName:String = ""
    
    var gbEmail: String = ""
    
    var gbPassword: String = ""
    
    var gbBal: Double = -1.0
    
    var bgJ1Title: String = ""
    
    var bgJ1Bal: Double = -1.0
    
    var bgJ1Goal: Double = -1.0
    
        
    @IBAction func LoginButton(_ sender: Any) {
        
        
        
        let email = _email.text
        let pass = _pass.text
        
        if(email == "" || pass == ""){
            return
        }
        
        DoLogin(email!, pass!)
        
        if(uFound == true){
            
            var semaphore = DispatchSemaphore (value: 0)
            var request = URLRequest(url: URL(string: "http://192.168.1.5:3000/api/v1/jars/"+(email)!)!,timeoutInterval: Double.infinity)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                return
              }
                let jJarFail = jJar(title: "null", description: "null", balance: -1.0, charge: -1.0, goal: -1.0, users: [])
                
                let jJarRequestFail = jJarResponse(message: "null", jars: [])
                
                
                func getJson()->(jJarResponse?){
                    do{
                        let juse = try JSONDecoder().decode(jJarResponse.self, from: data)
                        return juse
                    }
                    catch{
                        print(error)
                    }
                    return jJarRequestFail
                }
                
                let jMess = getJson()?.message
            
                let jJars = getJson()?.jars
                
                if(jMess != ""){
                    self.bgJ1Title = (jJars?[0].title)!
                    self.bgJ1Bal = (jJars?[0].balance)!
                    self.bgJ1Goal = (jJars?[0].goal)!
                }
                
                
            
                
                
                print(jJars?[0].title)
                
            
                //self.j1Lable.text = jJars?[0].title
            
                
              //print(String(data: data, encoding: .utf8)!)
            
                
              semaphore.signal()
                
            }
            task.resume()
            semaphore.wait()
            
            
            
            
            
            
            
            performSegue(withIdentifier: "logToJar", sender: self)
        }
        
    }
    
    
    
    
    func DoLogin(_ user:String, _ psw:String)
    {
        
        let semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\n\t\"username\": \"" + user + "\",\n\t\"password\": \"" + psw + "\"\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://192.168.1.5:3000/api/v1/users/validate")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {return}
            
            let jUserFail = jUser(email: "null", name: "null", password: "null", balance: -1.0)
            let jusermessagefail = jUserRespose(message: "null", user: jUserFail)
            
            
            func getJson()->(jUserRespose?){
                do{
                    let juse = try JSONDecoder().decode(jUserRespose.self, from: data)
                    return juse
                }
                catch{
                    print(error)
                }
                    return jusermessagefail
            }
            
            let jMess = getJson()?.message
             
            
            let jUser = getJson()?.user
            
            if(jMess == "User found"){
                self.uFound = true
                self.gbName = (jUser?.name)!
                self.gbEmail = (jUser?.email)!
                self.gbPassword = (jUser?.password)!
                self.gbBal = (jUser?.balance)!
            }
        
            
            
           //print(jMess)
        
            
            
            let dataStr = String(data: data, encoding: .utf8)
            

            
          //print(dataStr)
          semaphore.signal()
        

        }
        
        

        task.resume()
        semaphore.wait()
        
        
    
    }

    
    // global name
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var sc = segue.destination as! FirstViewController
        sc.name = gbName
        sc.email = gbEmail
        sc.password = gbPassword
        sc.balance = gbBal
        sc.j1Title = bgJ1Title
        sc.j1Balance = bgJ1Bal
        sc.j1Goal = bgJ1Goal
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

