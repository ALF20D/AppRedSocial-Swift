//
//  TwoViewController.swift
//  AppRedSocial
//
//  Created by admin on 13/10/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController, UITextFieldDelegate {

    var arrayPersonas = [Persona]()
    

    
    @IBOutlet weak var txtnombre: UITextField!
    
    
    @IBOutlet weak var txtapellido: UITextField!
    
    
    @IBOutlet weak var txtemail: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.cyan
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func up(_ sender: Any) {
        
        let persona = Persona()
        persona.name = txtnombre.text
        persona.lastname = txtapellido.text
        persona.email = txtemail.text
        persona.password = password.text
        
        arrayPersonas.append(persona)
        
        if persona.name != "" && persona.lastname != "" && persona.email != ""
            && persona.password != ""
        {
            let alertController = UIAlertController(title: "App", message: "Registro correcto", preferredStyle: .alert)
                   let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                   }
                   alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else
        {
            let alertController2 = UIAlertController(title: "App", message: "Llene todos los campos", preferredStyle: .alert)
                          let action2 = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
                          }
                          alertController2.addAction(action2)
            self.present(alertController2, animated: true, completion: nil)
        }
        
        
        
    }
    
    
   
}
