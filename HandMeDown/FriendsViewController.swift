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

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /// MARK: Properties
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var friends = [User]()
    
    /// MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser{
            
            // Firebase Storage 
            let storage = FIRStorage.storage()
            let storageRef = storage.reference(forURL: "gs://handmedown-557a0.appspot.com")
            let profilePictureRef = storageRef.child(user.uid+"/profile_pic.jpg")
            
            // download profile information
            let name = user.displayName
            let uid = user.uid
            self.nameLabel.text = name
            print("uid: \(uid)")
            
            // download profile picture
            if (self.pictureView.image == nil) {
                let profilePicture = FBSDKGraphRequest(graphPath: "\(uid)/picture", parameters: ["height":300, "width":300, "redirect": false], httpMethod: "GET")
                profilePicture?.start(completionHandler: {( connection, result, error) -> Void in
                    if (error == nil) {
                        let dictionary = result as? NSDictionary
                        let data = dictionary?.object(forKey: "data")
                        let urlPic = ((data as AnyObject).object(forKey: "url"))! as! String
                        if let imageData = NSData(contentsOf: NSURL(string: urlPic)! as URL)
                        {
                            let uploadTask = profilePictureRef.put(imageData as Data, metadata: nil) {
                                metadata, error in
                                if (error == nil)
                                {
                                    // size, content types or the download url
                                    let downloadUrl = metadata!.downloadURL()
                                }
                                else
                                {
                                    print("Error in downloading image")
                                }
                            }
                            self.pictureView.image = UIImage(data: imageData as Data)
                        }
                    }
                })
            } else {
                profilePictureRef.data(withMaxSize: 1 * 1024 * 1024) { data, error in
                    if (error != nil) {
                        print("Unable to download image")
                    } else {
                        if(data != nil) {
                            print("User already has an image, no need to download from Facebook")
                        }
                    }
                }
            }
            
            // download friends
     
            let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
            let friendsList = FBSDKGraphRequest(graphPath: "me/friends", parameters: params, httpMethod: "GET")
            friendsList?.start(completionHandler: {(connection, result, error) -> Void in
                if error != nil {
                    let errorMessage = error?.localizedDescription
                    print(errorMessage!)
                } else {
                    let dictionary = result as? NSDictionary
                    print("Result Dict: \(dictionary)")
                    let data : NSArray = dictionary!.object(forKey: "data") as! NSArray
                    
                    for i in 0 ..< data.count
                    {
                        let valueDict : NSDictionary = data[i] as! NSDictionary
                        let id = valueDict.object(forKey: "id") as! String
                        print("the id value is \(id)")
                    }
                    
                    let friends = dictionary?.object(forKey: "data") as! NSArray
                    print("Found \(friends.count) friends")
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
//                                {
//                                    let uploadTask = profilePictureRef.put(imageData as Data, metadata: nil) {
//                                        metadata, error in
//                                        if (error == nil)
//                                        {
//                                            // size, content types or the download url
//                                            let downloadUrl = metadata!.downloadURL()
//                                        }
//                                        else
//                                        {
//                                            print("Error in downloading image")
//                                        }
//                                    }
                                    let picture = imageData as! Data
                                    let user = User(name: name, picture: picture)
                                    self.friends.append(user)
                            }
                        })
                    }
                }
            })
        }
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
