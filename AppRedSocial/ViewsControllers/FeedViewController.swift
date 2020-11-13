//
//  HomeViewController.swift
//  AppRedSocial
//
//  Created by admin on 10/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fixedposts : [QueryDocumentSnapshot] = []
    
    @IBOutlet weak var TableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixedposts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellview", for: indexPath) as! TableViewCell
        cell.configure(owner: fixedposts[indexPath.row].data()["owner_uid"] as! String, posts: fixedposts[indexPath.row].data()["comment"] as! String)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.rowHeight = UITableView.automaticDimension
        
        // Execute on Load func comments
        
        comments {
            self.TableView.reloadData()
        }
    }
    
    
    
   
    
    
    func comments( completion:  @escaping () -> Void )
    {
        Firestore.firestore().collection("posts")
            .getDocuments { (querySnapshot, Err) in
                self.fixedposts = querySnapshot!.documents
                completion()
            }
    }
    
}
