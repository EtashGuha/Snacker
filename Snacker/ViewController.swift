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
import MapKit
import CoreLocation

class ViewController: UIViewController,  UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate{
    

    @IBOutlet weak var foodDescription: UITextField!
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var foodImage: UIImageView!
    var locationManager = CLLocationManager()
    var location: CLLocation!
    var postalCode: String!
    var country: String!
    var locationName: String!
    var city: String!
    var ref: DatabaseReference!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil{
                print("there was an error")
            } else {
                if let place = placemark?[0]{
                    self.locationName = place.name
                    self.postalCode = place.postalCode
                    self.city = place.locality
                    self.country = place.country
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imageData = foodImage.image?.jpegData(compressionQuality: 0.01)
        
        
        let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters)
        let stuffToPost = ["Time": Date().timeIntervalSince1970,
                           "Food Name" : foodDescription.text!,
                           "Picture": strBase64!,
                           "Latitude": location.coordinate.latitude,
                           "Longitude": location.coordinate.longitude,
                           "Address": getLocation()] as [String : Any]
        ref.child("Posts").childByAutoId().setValue(stuffToPost)
    }
    
    func getLocation() -> String{
        return locationName + "\n" + city + ", " + country + ", " + postalCode
    }
}

