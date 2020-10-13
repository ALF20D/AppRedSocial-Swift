//
//  ViewController.swift
//  AppRedSocial
//
//  Created by admin on 12/10/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var pass: UITextField!
  
    @IBOutlet weak var recoveremail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
    }


    @IBAction func iniciar(_ sender: Any) {
        // RIGHT CREDENTIALS...
        let alertController = UIAlertController(title: "App", message: "Credenciales correctas", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertController.addAction(action1)
         
         
         // WRONG EMAIL AND PASSWORD...
         
         let alertController2 = UIAlertController(title: "App", message: "Credenciales erróneas", preferredStyle: .alert)
               let action2 = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
               }
               alertController2.addAction(action2)
        
         
         let email = "admin@gmail.com"
         let password = "admin"
         if self.txtEmail.text == email && self.pass.text == password
         {
         self.present(alertController, animated: true, completion: nil)
         }
         else
         {
             self.present(alertController2, animated: true, completion: nil)
         }
    }
    
    
    
    
    
    @IBAction func final(_ sender: Any) {
        let alertController = UIAlertController(title: "App", message: "Credenciales correctas", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertController.addAction(action1)
        
        
        let alertController2 = UIAlertController(title: "App", message: "Credenciales erróneas", preferredStyle: .alert)
                   let action2 = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
                   }
                   alertController2.addAction(action2)
        
        if self.recoveremail.text == ""
        {
           
            self.present(alertController2, animated: true, completion: nil)
        }
        else
        {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
  
}

