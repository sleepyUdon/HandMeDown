//
//  MyStuffViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-15.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import RealmSwift
import FBSDKCoreKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth



class MyStuffViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    fileprivate var _refHandle: FIRDatabaseHandle!
    var items: [FIRDataSnapshot]! = []
    var uid = ""


    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.getFacebookProfile()
        self.ref = FIRDatabase.database().reference()
        let storage = FIRStorage.storage()
        self.storageRef = storage.reference(forURL: "gs://handmedown-557a0.appspot.com")
    }
    
    // MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.loadDataFromFirebase()
    }
    
    // MARK: get user Facebook id
    func getFacebookProfile() {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let dictionary = result as? NSDictionary
                    self.uid = dictionary?.object(forKey: "id") as! String
                }
            })
        }
    }
    
    // MARK: configure Database
    func loadDataFromFirebase() {
        self.ref.child("users").child("user-\(self.uid)").observe(.value, with: { snapshot in
            self.items = []
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                self.items.append(child)
                let mainQueue = DispatchQueue.main
                mainQueue.async {
                self.tableView.reloadData()
                }
            }
        })
    }
    
    
    // MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyStuffCell") as! MyStuffTableViewCell
        let itemSnapshot: FIRDataSnapshot! = self.items[indexPath.row]
        let item = itemSnapshot.value as! Dictionary<String, String>
        let title = item["title"] as String!
        let description = item["description"] as String!
        let key = itemSnapshot.key
        if let imageURL = item["photoURL"] as String! {
            self.storageRef.child("items").child("\(key)").child("\(title!).jpg").data(withMaxSize: INT64_MAX){ (data, error) in
                if let error = error {
                    print("Error downloading: \(error)")
                    return
                }
                cell.pictureView?.image = UIImage.init(data: data!)
            }
        }
        cell.titleLabel.text = title
        cell.descriptionLabel.text = description
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let item = items[indexPath.row]
            item.ref.removeValue()
            let key = item.key
            let userRef = self.ref.child("items").child("\(key)")
            print(userRef)
            userRef.removeValue()
        }
//        self.tableView.reloadData()

    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


