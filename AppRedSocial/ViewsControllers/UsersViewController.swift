//
//  UsersViewController.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 8/12/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    
    var documentId: String = ""
    var fixedUsers: [Dictionary<String, Any>] = []
    
    @IBOutlet weak var tableview: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userscell", for: indexPath) as! UsersTableViewCell
        
        let fullName = (self.fixedUsers[indexPath.row]["nombre"] as! String) + " " + (self.fixedUsers[indexPath.row]["apellido"] as! String)
        
        cell.configure(fullname: fullName, follower_uid: "")
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if(user != nil)
                   {
                self.loadUsers {
                    self.tableview.reloadData()
                    print(self.fixedUsers)
                }
            }
         }
    }

    func loadUsers( completion:  @escaping () -> Void ) {
        
        let ref = Database.database().reference()
        ref.child("users").observe(DataEventType.value) { (DataSnapshot) in
            for child in DataSnapshot.children.allObjects as! [DataSnapshot] {
                let dict = child.value as! Dictionary<String, Any>
                self.fixedUsers.append(dict)
            }
            self.tableview.reloadData()
            completion()
        }
    }
    
    @IBAction func Follow(_ sender: Any) {
        
    }
}
