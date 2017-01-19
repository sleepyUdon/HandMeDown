//
//  FirstViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-11-22.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import RealmSwift
import FBSDKCoreKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class GoodiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var uid = ""
    var username = ""
    fileprivate var _refHandle: FIRDatabaseHandle!
    var items: [FIRDataSnapshot]! = []

    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = FIRDatabase.database().reference()
        let storage = FIRStorage.storage()
        self.storageRef = storage.reference(forURL: "gs://handmedown-557a0.appspot.com")
        self.getFacebookProfile()
    }
    
    
    // MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.prepareLayout()
        self.loadDataFromFirebase()
    }
    
    
 // MARK: configure Database
    func loadDataFromFirebase() {
        self.ref.child("items").queryOrdered(byChild: "title").queryLimited(toLast: 10).observe(.value, with: { snapshot in
            self.items = []
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                self.items.append(child)
                let mainQueue = DispatchQueue.main
                mainQueue.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }

    

    
    // MARK: Prepare Layout
    func prepareLayout(){
        self.filterButton.layer.cornerRadius = self.filterButton.frame.height/2
        self.filterButton.backgroundColor = Colors.purple.light1
        self.filterButton.titleLabel?.font = Fonts.button.BT2
    }

    
    // MARK: get user Facebook id
    func getFacebookProfile() {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let dictionary = result as? NSDictionary
                    self.uid = dictionary?.object(forKey: "id") as! String
                    self.username = dictionary?.object(forKey: "name") as! String
                }
            })
        }
    }

    
    // MARK: CollectionView Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 30)/2, height:200)
    }
    
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodiesCollectionViewCell", for: indexPath) as! GoodiesCollectionViewCell
        
        let itemSnapshot: FIRDataSnapshot! = self.items[indexPath.row]
        let item = itemSnapshot.value as! Dictionary<String, String>
        let title = item["title"] as String!
        let key = itemSnapshot.key
        if let imageURL = item["photoURL"] as String! {
            self.storageRef.child("items").child("\(key)").child("\(title!).jpg").data(withMaxSize: INT64_MAX){ (data, error) in
                if let error = error {
                    print("Error downloading: \(error)")
                    return
                }
                cell.imageView?.image = UIImage.init(data: data!)
                cell.titleLabel.text = title

            }
        }
        
        return cell
    }




    // MARK: Actions

    // handle Logout Button
    @IBAction func handleLogoutButton(_ sender: UIButton) {
        
        // sign out user from Firebase
        print("User logged out of Firebase")
        try! FIRAuth.auth()?.signOut()
        FBSDKAccessToken.setCurrent(nil)
        
        // sign out user from Facebook
        print("User logged out of Facebook")
        FBSDKAccessToken.setCurrent(nil)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
        self.present(loginViewController, animated: true, completion: nil)
        
        // delete profile from Realm 
        let realm = try!Realm()
        try! realm.write {
            let user = realm.objects(MyProfile.self).first
            realm.delete(user!)
        }
    }
    
} // @end
    

