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
    
    @IBOutlet weak var PostButton: UIButton!
    
    var fixedposts : [Dictionary<String, AnyObject>] = []
    var key_post : [String] = []

    @IBOutlet weak var TableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixedposts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.commentViewController) as? CommentsViewController
        vc?.modalPresentationStyle = .popover
        vc?.uid = key_post[indexPath.row] as! String
        self.present(vc!, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellview", for: indexPath) as! TableViewCell
        cell.configure( comments: fixedposts[indexPath.row]["comment"] as! String, fullname: fixedposts[indexPath.row]["full_name"] as! String)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        TableView.rowHeight = UITableView.automaticDimension
        loadFeed {
            self.TableView.reloadData()
        }
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(PostButton)
    }
    
    
    @IBAction func PostClick(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.postViewController) as? PostViewController
        vc?.modalPresentationStyle = .popover
        self.present(vc!, animated: true, completion: nil)
       // self.navigationController?.pushViewController(vc!, animated: true)
        
    
    }
    
    
    func loadFeed( completion:  @escaping () -> Void ) {
        
        var ref: DatabaseReference!
                ref = Database.database().reference().child("posts")
        ref.observe(DataEventType.value) { (snapshot) in
            if self.fixedposts.count != 0
            {
                self.fixedposts.removeAll()
            }
            if self.key_post.count != 0
            {
                self.key_post.removeAll()
            }
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                self.key_post.append(child.key)
             let dict = child.value as! Dictionary <String, AnyObject>
                self.fixedposts.append(dict)
             }
            //print("------------------")
            //print(self.fixedposts)
            self.TableView.reloadData()
            completion()
            
        }
    }
}
