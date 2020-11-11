//
//  HomeViewController.swift
//  AppRedSocial
//
//  Created by admin on 10/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var PersonalInfo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if(user != nil)
                   {
                    
                       let users = Firestore.firestore().collection("users")
                    
                       let query = users.whereField("uid", isEqualTo: auth.currentUser?.uid)
                    
                        query.getDocuments { (querySnapshot, err) in
                            
                            if err != nil {
                                
                                print("Ocurrió un error.")
                            }
                            
                            //print(querySnapshot?.documents[0].data())
                            
                            for document in querySnapshot!.documents {
                                self.PersonalInfo.text = document.data()["nombre"] as? String
                            }
  
                    }
                           
                   }
        }
        
       
        
        

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

}
