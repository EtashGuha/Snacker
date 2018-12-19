//
//  PostTableViewController.swift
//  Snacker
//
//  Created by Etash Guha on 12/14/18.
//  Copyright © 2018 Etash Guha. All rights reserved.
//

import UIKit

struct cellData{
    let image: UIImage?
    let message: String?
}

class PostTableViewController: UITableViewController {
    
    var count: Int!
    var userString: String!
    var passedDataString: String = "chicken"
    var posts = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chat = UIImage(named: "burrito")
        posts = [cellData.init(image: chat, message: "example")]
        
        self.tableView.register( PostTableViewCell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
    }
    

    @IBAction func unwindToOne(_sender: UIStoryboardSegue){
        let cat = UIImage(named: "burrito")
        posts.append(cellData.init(image: cat, message: passedDataString))
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: posts.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! PostTableViewCell
        cell.foodPic = posts[indexPath.row].image
        cell.nameFood = posts[indexPath.row].message
        cell.layoutSubviews()
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
}


