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
import FBSDKCoreKit

class FriendsViewController: UIViewController {

    
    /// MARK: Properties
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = FIRAuth.auth()?.currentUser{
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid
            
            // Firebase Storage
            let storage = FIRStorage.storage()
            
            // reference to Firebase service
            let storageRef = storage.reference(forURL: "gs://handmedown-557a0.appspot.com")
            
            let profilePictureRef = storageRef.child(user.uid+"/profile_pic.jpg")
            
            profilePictureRef.data(withMaxSize: 1 * 1024 * 1024) { data, error in
                if (error != nil) {
                    print("Unable to download image")
                } else {
                    if(data != nil) {
                        print("User already has an image, no need to download from Facebook")
                        self.pictureView.image = UIImage(data: data!)
                    }
                }
            }
            
            if (self.pictureView.image == nil) {
                
                var profilePicture = FBSDKGraphRequest(graphPath: "me/picture", parameters: ["height":300, "width":300, "redirect": false], httpMethod: "GET")
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
                
            }
            self.nameLabel.text = name
            
        } else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
