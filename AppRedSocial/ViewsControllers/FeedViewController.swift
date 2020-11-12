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
  
    let owners: [String] = ["Alvaro Fiestas", "Romero Aquidez","Ricardo Garecca"]
    let posts : [String] = ["is simply dummy text of the printing and typesetting industry. Lorem Ipsum ","Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years","de Finibus Bonorum et Malorum The Extremes of Good and Evil by Cicero, written in 45 BC. This book is a treatise on the theory of ethics There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."]
    
    
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
        
        comments {
            //print(self.fixedposts[0].data()["comment"])
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
