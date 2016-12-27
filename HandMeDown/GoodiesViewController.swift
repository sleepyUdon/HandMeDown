//
//  FirstViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-11-22.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import Material
import RealmSwift
import FBSDKCoreKit
import FirebaseAuth
import FirebaseDatabase


class GoodiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: RaisedButton!
    var ref: FIRDatabaseReference!
    var uid = ""
    var username = ""
    fileprivate var _refHandle: FIRDatabaseHandle!
    var items: [FIRDataSnapshot]! = []


    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.prepareLayout()
        self.getFacebookProfile()
  
    }
    
    //
    deinit {
        self.ref.child("items").removeObserver(withHandle: _refHandle)
    }
    
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("items").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.items.append(snapshot)
//            strongSelf.collectionView.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
        })
    }
    


    //
    
    
    // MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    
    // MARK: Prepare Layout
    func prepareLayout(){
        self.filterButton.cornerRadius = self.filterButton.frame.height/2
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
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodiesCollectionViewCell", for: indexPath) as! GoodiesCollectionViewCell
        let itemSnapshot: FIRDataSnapshot! = self.items[indexPath.row]
        //        let item = itemSnapshot.value as! Dictionary<String, String>
        
        cell.imageView.image = UIImage(named: "Viviane")
        cell.userPictureView?.image = UIImage(named: "Viviane")
        cell.titleLabel.text = "Pikachu"
        cell.likeButton.setImage(UIImage(named:"empty-heart"), for: .normal)
        
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
    

