//
//  CommentsViewController.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 28/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fixedcomments : [Dictionary<String, AnyObject>] = []
    
    var uid = ""
    @IBOutlet weak var cardTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixedcomments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell", for: indexPath) as! CommentsCell
        cell.configure(fullname: fixedcomments[indexPath.row]["full_name"] as! String, comments: fixedcomments[indexPath.row]["comment"] as! String)
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(uid)
        
        cardTableView.rowHeight = UITableView.automaticDimension
        loadFeed {
            self.cardTableView.reloadData()
        }
        

    }
    
    func loadFeed( completion:  @escaping () -> Void ) {
            
            let ref : DatabaseReference!
            ref = Database.database().reference().child("comments")
            ref.queryOrdered(byChild: "post_uid").queryEqual(toValue: uid)
            .observe(DataEventType.value) { (snapshot) in
                if self.fixedcomments.count != 0
                {
                    self.fixedcomments.removeAll()
                }
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                 let dict = child.value as! Dictionary <String, AnyObject>
                    self.fixedcomments.append(dict)
                 }
                print(self.fixedcomments)
                self.cardTableView.reloadData()
                completion()
                
            }
        }
    

}
