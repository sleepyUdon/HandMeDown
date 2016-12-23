//
//  LoginViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-21.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.isHidden = true
        
        FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if let user = user {
                // User is signed in.
                // move to user to home screen
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController: MainTabBarController = mainStoryboard.instantiateViewController(withIdentifier: "HomeTabBar") as! MainTabBarController
                mainTabBarController.selectedIndex = 0
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
    
       
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            print("User Logged In to Firebase")
            if let error = error {
                print("User failed Logging in to Firebase")
                return
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }


    
    
   /*func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .PublicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .Failed(let error):
                print(error)
            case .Cancelled:
                print("User cancelled login.")
            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
            }
*/
}
