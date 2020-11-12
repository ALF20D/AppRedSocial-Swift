//
//  SignUpViewController.swift
//  AppRedSocial
//
//  Created by admin on 10/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var NombreTextField: UITextField!
    @IBOutlet weak var ApellidoTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RegistrarseButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
        
        // Ocultar label al iniciar.
        ErrorLabel.alpha = 0
        
        // Aplicar estilos a los elementos
        Utilities.styleTextField(NombreTextField)
        Utilities.styleTextField(ApellidoTextField)
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleFilledButton(RegistrarseButton)
        
    }
    
    func validateFields() -> String? {
        
        if NombreTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ApellidoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        
        {
            return "Por favor, llenar todos los campos."
        }
        
        let cleanPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanPassword) == false {
            return "Por favor, asegurese de que la contraseña tenga almenos 8 carácteres, un caracter especial y un número."
        }
        
        return nil
    }
   
    @IBAction func RegistarseTapped(_ sender: Any) {
        
        let error = validateFields()
        if error != nil {
            monstrarError(error!)
        }
        else {
            
            let nombre = NombreTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let apellido = ApellidoTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if  err != nil {
                    self.monstrarError("Error al crear usuario.")
                }
                else
                {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "nombre": nombre,
                        "apellido": apellido,
                        "uid":result!.user.uid
                    ]) { (error) in
                        if error != nil {
                            self.monstrarError("Ocurrió un error al guardar la información de usuario.")
                        }
                    }
                    // Open...
                    self.transitionToHome()
                }
            }
        }
    }
    
    func transitionToHome() {
        
        let feedViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.feedViewController) as? FeedViewController
        view.window?.rootViewController = feedViewController
        view.window?.makeKeyAndVisible()
    }
    
    func monstrarError(_ msg: String)  {
        ErrorLabel.text = msg
        ErrorLabel.alpha = 1
    }
}
