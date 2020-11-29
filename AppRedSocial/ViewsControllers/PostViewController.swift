//
//  PostViewController.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 29/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    
   
    var FullName : String = ""
    var uid : String = ""
    
    @IBOutlet weak var PostButton: UIButton!
    
    
    @IBOutlet weak var CommentPostTextField: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        Utilities.styleHollowButton(PostButton)
        Utilities.styleUITextField(CommentPostTextField)
    }

    @IBAction func PostClick(_ sender: Any) {
        postComment()
        dismiss(animated: true, completion: nil)
    }
    
    
   func postComment()
   {
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
                        self.FullName = (document.data()["nombre"] as! String) + " " + (document.data()["apellido"] as! String)
                        self.uid = (document.data()["uid"] as! String)
                    }

                    let ref: DatabaseReference! = Database.database().reference()
                    ref.child("posts").childByAutoId().setValue(["comment": self.CommentPostTextField.text! as NSString, "full_name": self.FullName as NSString, "owner_uid": self.uid as NSString])
               }
            }
       }
   }
    

}
