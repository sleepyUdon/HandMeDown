//
//  SecondViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-11-22.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import Material
import FirebaseDatabase
import FirebaseStorage
import FBSDKCoreKit



class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {

    /// MARK: Properties
    @IBOutlet weak var boyButton: RaisedButton!
    @IBOutlet weak var girlButton: RaisedButton!
    @IBOutlet weak var babyButton: RaisedButton!
    @IBOutlet weak var toddlerButton: RaisedButton!
    @IBOutlet weak var kidButton: RaisedButton!
    @IBOutlet weak var tweenButton: RaisedButton!
    @IBOutlet weak var teenButton: RaisedButton!
    @IBOutlet weak var clothesButton: RaisedButton!
    @IBOutlet weak var toyButton: RaisedButton!
    @IBOutlet weak var bookButton: RaisedButton!
    @IBOutlet weak var gearButton: RaisedButton!
    @IBOutlet weak var electronicsButton: RaisedButton!
    @IBOutlet weak var sportsButton: RaisedButton!
    @IBOutlet weak var furnitureButton: RaisedButton!
    @IBOutlet weak var otherButton: RaisedButton!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var pictureButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cameraView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextfield: UITextField!
    
    let picker = UIImagePickerController()
    var itemTitle: String?
    var itemDescription: String?
    var pictureData: NSData?
    var categories = [String]()
    var ref: FIRDatabaseReference!
    var itemRef: FIRDatabaseReference!
    var userRef: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var uid: String?
    var username: String?
    
    
    /// MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // create reference to Firebase database
        self.ref = FIRDatabase.database().reference()
        // create reference to Firebase database to items node
        self.itemRef = self.ref.child("items")
        // create reference to Firebase database to users node
        self.userRef = self.ref.child("users")
        // create reference to Firebase storage
        let storage = FIRStorage.storage()
        self.storageRef = storage.reference(forURL: "gs://handmedown-557a0.appspot.com")
        // set image picker and textfield delegates
        picker.delegate = self
        self.titleTextfield.delegate = self
        self.getFacebookProfile()
        
     
    }
    

    // MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.prepareLayout()
    }
    
    
    /// MARK: Prepare Layout
    func prepareLayout() {
        containerView.alpha = 0
        containerView.cornerRadius = 5.0
        UIView.animate(withDuration: 0.5) {
            self.containerView.alpha = 1
        }
        
        boyButton.isSelected = false
        boyButton.titleLabel?.font = Fonts.body.B4
        boyButton.cornerRadius = boyButton.frame.height / 2
        
        girlButton.isSelected = false
        girlButton.titleLabel?.font = Fonts.body.B4
        girlButton.cornerRadius = boyButton.frame.height / 2
        
        
        babyButton.isSelected = false
        babyButton.titleLabel?.font = Fonts.body.B4
        babyButton.cornerRadius = boyButton.frame.height / 2
        
        
        toddlerButton.isSelected = false
        toddlerButton.titleLabel?.font = Fonts.body.B4
        toddlerButton.cornerRadius = boyButton.frame.height / 2
        
        
        kidButton.isSelected = false
        kidButton.titleLabel?.font = Fonts.body.B4
        kidButton.cornerRadius = boyButton.frame.height / 2
        
        
        tweenButton.isSelected = false
        tweenButton.titleLabel?.font = Fonts.body.B4
        tweenButton.cornerRadius = boyButton.frame.height / 2
        
        
        teenButton.isSelected = false
        teenButton.titleLabel?.font = Fonts.body.B4
        teenButton.cornerRadius = boyButton.frame.height / 2
        
        
        clothesButton.isSelected = false
        clothesButton.titleLabel?.font = Fonts.body.B4
        clothesButton.cornerRadius = boyButton.frame.height / 2
        
        
        toyButton.isSelected = false
        toyButton.titleLabel?.font = Fonts.body.B4
        toyButton.cornerRadius = boyButton.frame.height / 2
        
        
        bookButton.isSelected = false
        bookButton.titleLabel?.font = Fonts.body.B4
        bookButton.cornerRadius = boyButton.frame.height / 2
        
        
        gearButton.isSelected = false
        gearButton.titleLabel?.font = Fonts.body.B4
        gearButton.cornerRadius = boyButton.frame.height / 2
        
        
        electronicsButton.isSelected = false
        electronicsButton.titleLabel?.font = Fonts.body.B4
        electronicsButton.cornerRadius = boyButton.frame.height / 2
        
        
        sportsButton.isSelected = false
        sportsButton.titleLabel?.font = Fonts.body.B4
        sportsButton.cornerRadius = boyButton.frame.height / 2
        
        
        furnitureButton.isSelected = false
        furnitureButton.titleLabel?.font = Fonts.body.B4
        furnitureButton.cornerRadius = boyButton.frame.height / 2
        
        
        otherButton.isSelected = false
        otherButton.titleLabel?.font = Fonts.body.B4
        otherButton.cornerRadius = boyButton.frame.height / 2
    }
    
    
    
    // MARK: get user Facebook id
    func getFacebookProfile() {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let dictionary = result as? NSDictionary
                    self.uid = dictionary?.object(forKey: "id") as! String?
                    self.username = dictionary?.object(forKey: "name") as! String?
                }
            })
        }
    }

 

    // MARK: TextField Delegate
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.itemTitle = titleTextfield.text
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextfield.resignFirstResponder()
        return true
    }
    
    
    
    // MARK: Handle Post Button
    
    @IBAction func HandlePostButton(_ sender: UIButton) {
        
        let someNSDate = NSDate()
        let timeStamp = Int(someNSDate.timeIntervalSince1970)
        let itemID = "item-\(self.uid!)-\(timeStamp)"
        // items node
        
        let newItemRef = self.itemRef.child("\(itemID)")
        newItemRef.child("title").setValue(self.itemTitle)
        newItemRef.child("description").setValue("Very Cute")
        newItemRef.child("uid").setValue(self.uid)
        newItemRef.child("username").setValue(self.username)
        for category in self.categories {
            newItemRef.child("categories").child(category).setValue(true)
        }
        
        // users node
        let inventoryRef = self.userRef.child("user-\(self.uid!)").child("\(itemID)")
        inventoryRef.child("title").setValue(self.itemTitle)
        inventoryRef.child("description").setValue("Very Cute")
        
        
        //
        let itemsImagesRef = self.storageRef.child("items").child("\(itemID)").child("\(self.itemTitle!).jpg")
        let itemUploadTask = itemsImagesRef.put(self.pictureData as! Data, metadata: nil) { (metadata, error) in
            if let error = error {
                let nsError = error as NSError
                print("Error uploading: \(nsError.localizedDescription)")
                return
            } else {
                let url = metadata?.downloadURL()
                newItemRef.child("photoURL").setValue("\(url!)")
            }
        }
    }
    

    
    
    
    
    /// MARK: Handle Add Picture Button
    
    @IBAction func HandleAddPictureButton(_ sender: UIButton) {
        self.pictureButton.setTitle("", for: .normal)
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        
        // Add the actions
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker, animated: true, completion: nil)
        }else{
            
            let alert = UIAlertController(title:"Warning",
                                          message: "Please change setting for camera in Setings",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }
    }
    func openGallery(){
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    /// Save Picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage: UIImage = (info as NSDictionary).object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
        cameraView.isHidden = true
        let pictureData = UIImageJPEGRepresentation(pickedImage, 0.5)
        self.pictureData = pictureData as NSData?
        pictureView.image = UIImage(data: pictureData!)
        self.dismiss(animated: true, completion: nil)
    }
    

    
    // Dismiss Image Picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    /// MARK: Handle Tags Button
    
    // Boy Button
    
    @IBAction func boyButton(_ sender: RaisedButton) {
        if self.boyButton.isSelected == false {
            self.boyButton.backgroundColor = Colors.blue.light2
            self.boyButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.boyButton.isSelected = true
            self.categories.append("Boy")
        } else {
            self.boyButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.boyButton.isSelected = false
            self.boyButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Boy") {
                self.categories.remove(at: index)
            }
        }
    }
    
    
    // Girl Button
    
    @IBAction func girlButton(_ sender: RaisedButton) {
        if self.girlButton.isSelected == false {
            self.girlButton.backgroundColor = Colors.blue.light2
            self.girlButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.girlButton.isSelected = true
            self.categories.append("Girl")

        } else {
            self.girlButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.girlButton.isSelected = false
            self.girlButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Girl") {
                self.categories.remove(at: index)
            }
        }
    }
    
    
    // Baby Button
    
    @IBAction func babyButton(_ sender: RaisedButton) {
        if self.babyButton.isSelected == false {
            self.babyButton.backgroundColor = Colors.blue.light2
            self.babyButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.babyButton.isSelected = true
            self.categories.append("Baby")

        } else {
            self.babyButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.babyButton.isSelected = false
            self.babyButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Baby") {
                self.categories.remove(at: index)
            }
        }
    }
    
    
    // Toddler Button
    
    @IBAction func toddlerButton(_ sender: RaisedButton) {
        if self.toddlerButton.isSelected == false {
            self.toddlerButton.backgroundColor = Colors.blue.light2
            self.toddlerButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.toddlerButton.isSelected = true
            self.categories.append("Toddler")

        } else {
            self.toddlerButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.toddlerButton.isSelected = false
            self.toddlerButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Toddler") {
                self.categories.remove(at: index)
            }
        }
    }
    
    // Kid Button
    
    @IBAction func kidButton(_ sender: Button) {
        if self.kidButton.isSelected == false {
            self.kidButton.backgroundColor = Colors.blue.light2
            self.kidButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.kidButton.isSelected = true
            self.categories.append("Kid")

        } else {
            self.kidButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.kidButton.isSelected = false
            self.kidButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Kid") {
                self.categories.remove(at: index)
            }
        }
    }
    
    // Tween Button
    
    @IBAction func tweenButton(_ sender: RaisedButton) {
        if self.tweenButton.isSelected == false {
            self.tweenButton.backgroundColor = Colors.blue.light2
            self.tweenButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.tweenButton.isSelected = true
            self.categories.append("Tween")

        } else {
            self.tweenButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.tweenButton.isSelected = false
            self.tweenButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Tween") {
                self.categories.remove(at: index)
            }
        }
    }
    
    // Teen Button
    
    @IBAction func teenButton(_ sender: RaisedButton) {
        if self.teenButton.isSelected == false {
            self.teenButton.backgroundColor = Colors.blue.light2
            self.teenButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.teenButton.isSelected = true
            self.categories.append("Teen")

        } else {
            self.teenButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.teenButton.isSelected = false
            self.teenButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Teen") {
                self.categories.remove(at: index)
            }
        }
    }
    
    // Clothes Button
    
    @IBAction func clothesButton(_ sender: RaisedButton) {
        if self.clothesButton.isSelected == false {
            self.clothesButton.backgroundColor = Colors.blue.light2
            self.clothesButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.clothesButton.isSelected = true
            self.categories.append("Clothes")

        } else {
            self.clothesButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.clothesButton.isSelected = false
            self.clothesButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Clothes") {
                self.categories.remove(at: index)
            }
        }
    }
    
    // Toy Button
    
    @IBAction func toyButton(_ sender: RaisedButton) {
        if self.toyButton.isSelected == false {
            self.toyButton.backgroundColor = Colors.blue.light2
            self.toyButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.toyButton.isSelected = true
            self.categories.append("Toy")

        } else {
            self.toyButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.toyButton.isSelected = false
            self.toyButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Toy") {
                self.categories.remove(at: index)
            }
        }
    }
    
    
    // Book Button
    
    @IBAction func bookButton(_ sender: RaisedButton) {
        if self.bookButton.isSelected == false {
            self.bookButton.backgroundColor = Colors.blue.light2
            self.bookButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.bookButton.isSelected = true
            self.categories.append("Book")

        } else {
            self.bookButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.bookButton.isSelected = false
            self.bookButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Book") {
                self.categories.remove(at: index)
            }
        }
    }
    
    
    // Gear Button
    
    @IBAction func gearButton(_ sender: Button) {
        if self.gearButton.isSelected == false {
            self.gearButton.backgroundColor = Colors.blue.light2
            self.gearButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.gearButton.isSelected = true
            self.categories.append("Gear")

        } else {
            self.gearButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.gearButton.isSelected = false
            self.gearButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Gear") {
                self.categories.remove(at: index)
            }
        }
    }
    
    
    // Electronics Button
    
    @IBAction func electronicsButton(_ sender: RaisedButton) {
        if self.electronicsButton.isSelected == false {
            self.electronicsButton.backgroundColor = Colors.blue.light2
            self.electronicsButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.electronicsButton.isSelected = true
            self.categories.append("Electronics")

        } else {
            self.electronicsButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.electronicsButton.isSelected = false
            self.electronicsButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Electronics") {
                self.categories.remove(at: index)
            }
        }
    }
    
    
    // Sports Button
    
    @IBAction func sportsButton(_ sender: RaisedButton) {
        if self.sportsButton.isSelected == false {
            self.sportsButton.backgroundColor = Colors.blue.light2
            self.sportsButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.sportsButton.isSelected = true
            self.categories.append("Sports")

        } else {
            self.sportsButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.sportsButton.isSelected = false
            self.sportsButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Sports") {
                self.categories.remove(at: index)
            }
        }
    }
    
    
    
    // Furniture Button
    
    @IBAction func furnitureButton(_ sender: RaisedButton) {
        if self.furnitureButton.isSelected == false {
            self.furnitureButton.backgroundColor = Colors.blue.light2
            self.furnitureButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.furnitureButton.isSelected = true
            self.categories.append("Furniture")

        } else {
            self.furnitureButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.furnitureButton.isSelected = false
            self.furnitureButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Furniture") {
                self.categories.remove(at: index)
            }
        }
    }
    
    
    // Other Button
    
    @IBAction func otherButton(_ sender: RaisedButton) {
        if self.otherButton.isSelected == false {
            self.otherButton.backgroundColor = Colors.blue.light2
            self.otherButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.otherButton.isSelected = true
            self.categories.append("Other")

        } else {
            self.otherButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.otherButton.isSelected = false
            self.otherButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            if let index = self.categories.index(of: "Other") {
                self.categories.remove(at: index)
            }
        }
    }
    
    
}


