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

class ViewController: UIViewController,  UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBOutlet weak var foodDescription: UITextField!
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        self.present(image, animated: true){}
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            foodImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imageData = foodImage.image?.jpegData(compressionQuality: 0.01)
        let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters)
        let stuffToPost = ["addasdfasdfress", foodDescription.text!, strBase64] as [Any]
        ref.child("Posts").childByAutoId().setValue(stuffToPost)
    }
}

