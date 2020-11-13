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
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if(user != nil)
                
                   {
                    
                   Firestore.firestore().collection("users")
                    .whereField("uid", isEqualTo: auth.currentUser?.uid as Any)
                     .getDocuments { (querySnapshot, err) in
                            if err != nil {
                                print("Ocurrió un error.")
                            }
                            //print(querySnapshot?.documents[0].data())
                            for document in querySnapshot!.documents {
                               self.nameLabel.text = document.data()["nombre"] as? String
                                
                                print("Desde Profile: ",document.data()["nombre"] as? String)
                            }
                       }
                           
                   }
        }

    }
    
}
