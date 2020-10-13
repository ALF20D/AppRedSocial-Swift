//
//  TwoViewController.swift
//  AppRedSocial
//
//  Created by admin on 13/10/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {

    var arrayPersonas = [Persona]()
    
    //TEXTEDIT...
    
    @IBOutlet weak var txtnombre: UITextField!
    
    
    @IBOutlet weak var txtapellido: UITextField!
    
    
    @IBOutlet weak var txtemail: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
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
        
        for elemento in arrayPersonas {
            print(elemento.name)
        }
    }
}
