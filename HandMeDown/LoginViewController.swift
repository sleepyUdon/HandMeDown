//
//  LoginViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-21.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    /// MARK: Properties
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var loginButton = FBSDKLoginButton()

    
    /// MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Settings
        self.loginButton.isHidden = true
        
        // Listen to state of user
        FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if (user != nil) {
                // User is signed in.
                // move to user to home screen
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController: MainTabBarController = mainStoryboard.instantiateViewController(withIdentifier: "HomeTabBar") as! MainTabBarController
                mainTabBarController.selectedIndex = 2
                self.present(mainTabBarController, animated: true, completion: nil)
                
            } else {
                // No user is signed in.
                // show the user the login button
                self.loginButton.center = self.view.center
                self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
                self.loginButton.delegate = self
                self.view.addSubview(self.loginButton)
                self.loginButton.isHidden = false
            }
        }
    }
    
       
    /// MARK: LoginButtonDelegate

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        self.loginButton.isHidden = true
        activityIndicator.startAnimating()
        if(error != nil) {
            // handle error here
            self.loginButton.isHidden = false
            activityIndicator.stopAnimating()
        }
        else if(result.isCancelled){
            // handle the cancel event
            self.loginButton.isHidden = false
            activityIndicator.stopAnimating()
        } else {
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                print("User Logged In to Firebase")
                self.loadProfile()
                if (error != nil) {
                    print("User failed Logging in to Firebase")
                    return
                }
            }
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func loadProfile(){
        if let user = FIRAuth.auth()?.currentUser{
            
            // download profile information
            let name = user.displayName
            
            // download profile picture
            let realm = try!Realm()
            let me = realm.objects(MyProfile.self)
            if (me.count <= 0) {
                let profilePicture = FBSDKGraphRequest(graphPath: "me/picture", parameters: ["height":300, "width":300, "redirect": false], httpMethod: "GET")
                profilePicture?.start(completionHandler: {( connection, result, error) -> Void in
                    if (error == nil) {
                        let dictionary = result as? NSDictionary
                        let data = dictionary?.object(forKey: "data")
                        let urlPic = ((data as AnyObject).object(forKey: "url"))! as! String
                        let imageData = NSData(contentsOf: NSURL(string: urlPic)! as URL)
                        let myProfile = MyProfile(name: name!, image: imageData! as Data)
                        try! realm.write {
                            realm.add(myProfile)
                        }
                    }
                })
            }
        }
    }
    
    
} //@end
