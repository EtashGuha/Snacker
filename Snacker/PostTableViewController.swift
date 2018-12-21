//
//  PostTableViewController.swift
//  Snacker
//
//  Created by Etash Guha on 12/14/18.
//  Copyright © 2018 Etash Guha. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit

struct cellData{
    let image: UIImage?
    let message: String?
}

class PostTableViewController: UITableViewController, CLLocationManagerDelegate{
    
    var count: Int!
    var userString: String!
    var passedDataString: String = "chicken"
    var posts = [cellData]()
    var imageToBeAdded: UIImage!
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var locationManager = CLLocationManager()
    var location: CLLocation!
    var postalCode: String!
    var country: String!
    var locationName: String!
    var city: String!
    var firstTimeReadingDatabase = true
    let dayToSeconds = 86400
    let metersToMiles = 3 * 1609
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chat = UIImage(named: "burrito")
        posts = [cellData.init(image: chat, message: "example")]
        
        self.tableView.register( PostTableViewCell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    

    @IBAction func unwindToOne(_sender: UIStoryboardSegue){
        //updateTableView()
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
    
    func updateTableView(message: String, strBase64: String){
        let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        posts.insert(cellData.init(image: decodedimage, message: message), at: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        tableView.endUpdates()
    }
    
    func readFromFirebase(){
        ref = Database.database().reference()
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                let otherLocation = CLLocation(latitude: data["Latitude"] as! CLLocationDegrees, longitude: data["Longitude"] as! CLLocationDegrees)
                let distanceInMeters = self.location.distance(from: otherLocation)
                if Int(distanceInMeters) < self.metersToMiles && Int((Date().timeIntervalSince1970 - (data["Time"] as! Double))) < self.dayToSeconds {
                    self.updateTableView(message: (data["Food Name"] as? String)!, strBase64: (data["Picture"] as? String)!)
                }
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
        if firstTimeReadingDatabase {
            firstTimeReadingDatabase = false
            readFromFirebase()
        }
    }
}


