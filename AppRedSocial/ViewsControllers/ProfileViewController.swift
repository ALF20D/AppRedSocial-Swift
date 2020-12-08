//
//  ProfileViewController.swift
//  AppRedSocial
//
//  Created by admin on 12/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    var documentId: String = ""
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    @IBOutlet weak var EditNombreButton: UIButton!
    @IBOutlet weak var EditApellidoButton: UIButton!
    @IBOutlet weak var GuardarButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if(user != nil)
                   {
                Firestore.firestore().collection("users")
                    
                    .whereField("uid", isEqualTo: auth.currentUser?.uid as Any)
                    
                     .getDocuments { (querySnapshot, err) in
                            if err != nil {
                                print("Ocurrió un error.")
                            }
                            for document in querySnapshot!.documents {
                                self.documentId = document.documentID
                                self.nombreTextField.text = document.data()["nombre"] as? String
                                self.apellidoTextField.text = document.data()["apellido"] as? String
                            }
                       }
                }
         }

    }
    
    
    @IBAction func NombreClick(_ sender: Any) {
        GuardarButton.alpha = 1
        nombreTextField.isUserInteractionEnabled = true
        nombreTextField.becomeFirstResponder()
    }
    
    
    @IBAction func ApellidoClick(_ sender: Any) {
        GuardarButton.alpha = 1
        apellidoTextField.isUserInteractionEnabled = true
        apellidoTextField.becomeFirstResponder()
    }
    
    
    @IBAction func GuardarClick(_ sender: Any) {
        GuardarButton.alpha = 0
        nombreTextField.isUserInteractionEnabled = false
        apellidoTextField.isUserInteractionEnabled = false
        
        // Update Firestore document...
        Auth.auth().addStateDidChangeListener { (auth, user) in
            let dbRef = Firestore.firestore().collection("users").document(self.documentId)
            dbRef.updateData(["nombre" : self.nombreTextField.text!, "apellido" : self.apellidoTextField.text!])
        }
    }
    
    func setupElements()
    {
        GuardarButton.alpha = 0
        Utilities.styleHollowButton(GuardarButton)
    }
    
}
