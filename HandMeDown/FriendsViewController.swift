//
//  FriendsViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-23.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import FBSDKCoreKit
import RealmSwift

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /// MARK: Properties
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var friends = [User]()
    
    /// MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // download profile name and picture from Realm
        let realm = try! Realm()
        let me = realm.objects(MyProfile.self).first
        let name = me?.name
        let picture = me?.image
        
        self.pictureView.image = UIImage(data: picture! as Data)
        self.nameLabel.text = name
        
        // download friends
        let params = ["fields": "id, name, picture"]
        let friendsList = FBSDKGraphRequest(graphPath: "me/friends", parameters: params, httpMethod: "GET")
        friendsList?.start(completionHandler: {(connection, result, error) -> Void in
            if error != nil {
                let errorMessage = error?.localizedDescription
                print(errorMessage!)
            } else {
                let dictionary = result as? NSDictionary
                let data : NSArray = dictionary!.object(forKey: "data") as! NSArray
                
                let friends = dictionary?.object(forKey: "data") as! NSArray
                for friend in friends {
                    let name = (friend as AnyObject).object(forKey: "name") as! String
                    let id = (friend as AnyObject).object(forKey: "id") as! String
                    
                    var profilePicture = FBSDKGraphRequest(graphPath: "\(id)/picture", parameters: ["height":300, "width":300, "redirect": false], httpMethod: "GET")
                    profilePicture?.start(completionHandler: {( connection, result, error) -> Void in
                        if (error == nil) {
                            let dictionary = result as? NSDictionary
                            let data = dictionary?.object(forKey: "data")
                            let urlPic = ((data as AnyObject).object(forKey: "url"))! as! String
                            let imageData = NSData(contentsOf: NSURL(string: urlPic)! as URL)
                            let picture = imageData as! Data
                            let user = User(name: name, picture: picture)
                            self.friends.append(user)
                        }
                        self.tableView.reloadData()
                    })
                }
            }
        })
    }
    
    
    
    
    
    /// MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    /// MARK: Tableview Datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(friends.count)
        return friends.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = friends[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendsTableViewCell
        cell.configureWithUser(user: user)
        print(friends)
        return cell
    }
    
    
}
