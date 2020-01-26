//
//  AddViewController.swift
//  SplitJar
//
//  Created by Robert Elizondo on 1/26/20.
//  Copyright © 2020 Robert Elizondo. All rights reserved.
//

import UIKit

class AddViewController: UITabBarController {
    
    var addAmount = String()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("IN ADD PAGE")
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTo(_ sender: Any) {
        
         performSegue(withIdentifier: "backToJars", sender: self)
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        addField.resignFirstResponder()
//    }

}

//extension AddViewController : UITextFieldDelegate{
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}
