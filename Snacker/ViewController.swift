//
//  ViewController.swift
//  Snacker
//
//  Created by Etash Guha on 12/14/18.
//  Copyright © 2018 Etash Guha. All rights reserved.
//

import UIKit
import Firebase
import os.log

class ViewController: UIViewController,  UINavigationControllerDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var foodDescription: UITextField!
    @IBOutlet weak var save: UIBarButtonItem!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.text = "hi"
        ref = Database.database().reference()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let stuffToPost = ["addasdfasdfress", foodDescription.text] as [Any]
        ref.child("Posts").childByAutoId().setValue(stuffToPost)
        let destvc = segue.destination as! PostTableViewController
        destvc.passedDataString = foodDescription.text!
    }
}

