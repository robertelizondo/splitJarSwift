//
//  FirstViewController.swift
//  splitJar
//
//  Created by Robert Elizondo on 1/25/20.
//  Copyright © 2020 Robert Elizondo. All rights reserved.
//

import UIKit

import Foundation

class FirstViewController: UIViewController {
    

    var name = String()
    
    var email = String()
    
    var password = String()
    
    var balance = Double()

    var j1Title = String()
    
    var j1Balance = Double()
//    
    var j1Goal = Double()
//    
  

    @IBAction func accountButton(_ sender: Any) {
        performSegue(withIdentifier: "toAcct", sender: self)
        
    }
    
    
//    @IBAction func addButton(_ sender: Any) {
//
//        performSegue(withIdentifier: "toAdd", sender: self)
//
//    }
    

    


    @IBOutlet var jarOne: UILabel!
    

    @IBOutlet var perOne: UILabel!
    
    @IBOutlet var balOne: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(email)
        
        print(password)
        
        jarOne.text = j1Title
        
        perOne.text = String((j1Balance/j1Goal)*100)

        balOne.text = String(j1Balance)
        
    
    }
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var sc = segue.destination as! SecondViewController
        sc.name = name
        sc.email = email
        sc.balance = balance
        //sc.password = password
    }
    
    
    
    
    

 
    
    
    
}


