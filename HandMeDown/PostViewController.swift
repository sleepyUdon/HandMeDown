//
//  SecondViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-11-22.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import Material
import RealmSwift

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {

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
    
    // MARK: Set up properties

//    var picture: UIImage? {
//        didSet {
//            let picture = UIImage {
//                let data = **picture from camera**
//                picture = UIImage(data: pictureData)
//            }

    var itemTitle: String?
    var itemDescription: String?
    let picker = UIImagePickerController()
    
    var pictureData: NSData?
    var categories = [String]()
    let items: [Item] = {
        let realm = try! Realm()
        return Array(realm.objects(Item))
   }()

    
            
    // ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.titleTextfield.delegate = self
    }
    

    // ViewWillAppear

    override func viewWillAppear(_ animated: Bool) {
        self.prepareLayout()
    }
    
    
// MARK: Prepare Layout
    
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
    
    
    // MARK: TextField Delegate

    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.itemTitle = titleTextfield.text
    }

    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextfield.resignFirstResponder()
        return true
    }
    
// MARK: Actions
    
    
    // Handle Post Button
    
    @IBAction func HandlePostButton(_ sender: UIButton) {
        let realm = try! Realm()
        let item = Item()
        item.title = self.itemTitle!
        item.itemDescription = "Very Cute"
        item.image = self.pictureData
        item.like = "empty-heart"

        for category in self.categories {
            let cat = Category(name: category)
            item.categories.append(cat)
        }
        item.user = "Viviane"
        
        try! realm.write {
            realm.add(item)
        }
    }
    
    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
    
    // MARK: Handle Add Picture Button
    
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
        let pictureData = UIImageJPEGRepresentation(pickedImage, 1.0)
        self.pictureData = pictureData as NSData?
        pictureView.image = UIImage(data: pictureData!)
        self.dismiss(animated: true, completion: nil)
    }
    
    // Dismiss Image Picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }



    // MARK: Handle Tags Button
    
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
            if let index = categories.index(of: "Boy") {
                categories.remove(at: index)
            }
        }
    }
    
    
    // Girl Button

    @IBAction func girlButton(_ sender: RaisedButton) {
        if self.girlButton.isSelected == false {
            self.girlButton.backgroundColor = Colors.blue.light2
            self.girlButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.girlButton.isSelected = true
        } else {
            self.girlButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.girlButton.isSelected = false
            self.girlButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
}


    // Baby Button

    @IBAction func babyButton(_ sender: RaisedButton) {
        if self.babyButton.isSelected == false {
            self.babyButton.backgroundColor = Colors.blue.light2
            self.babyButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.babyButton.isSelected = true
        } else {
            self.babyButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.babyButton.isSelected = false
            self.babyButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
    // Toddler Button

    @IBAction func toddlerButton(_ sender: RaisedButton) {
        if self.toddlerButton.isSelected == false {
            self.toddlerButton.backgroundColor = Colors.blue.light2
            self.toddlerButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.toddlerButton.isSelected = true
        } else {
            self.toddlerButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.toddlerButton.isSelected = false
            self.toddlerButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    // Kid Button
    
    @IBAction func kidButton(_ sender: Button) {
        if self.kidButton.isSelected == false {
            self.kidButton.backgroundColor = Colors.blue.light2
            self.kidButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.kidButton.isSelected = true
        } else {
            self.kidButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.kidButton.isSelected = false
            self.kidButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    // Tween Button
    
    @IBAction func tweenButton(_ sender: RaisedButton) {
        if self.tweenButton.isSelected == false {
            self.tweenButton.backgroundColor = Colors.blue.light2
            self.tweenButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.tweenButton.isSelected = true
        } else {
            self.tweenButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.tweenButton.isSelected = false
            self.tweenButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    // Teen Button
    
    @IBAction func teenButton(_ sender: RaisedButton) {
        if self.teenButton.isSelected == false {
            self.teenButton.backgroundColor = Colors.blue.light2
            self.teenButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.teenButton.isSelected = true
        } else {
            self.teenButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.teenButton.isSelected = false
            self.teenButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    // Clothes Button
    
    @IBAction func clothesButton(_ sender: RaisedButton) {
        if self.clothesButton.isSelected == false {
            self.clothesButton.backgroundColor = Colors.blue.light2
            self.clothesButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.clothesButton.isSelected = true
        } else {
            self.clothesButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.clothesButton.isSelected = false
            self.clothesButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }

    // Toy Button
    
    @IBAction func toyButton(_ sender: RaisedButton) {
        if self.toyButton.isSelected == false {
            self.toyButton.backgroundColor = Colors.blue.light2
            self.toyButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.toyButton.isSelected = true
        } else {
            self.toyButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.toyButton.isSelected = false
            self.toyButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
    // Book Button
    
    @IBAction func bookButton(_ sender: RaisedButton) {
        if self.bookButton.isSelected == false {
            self.bookButton.backgroundColor = Colors.blue.light2
            self.bookButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.bookButton.isSelected = true
        } else {
            self.bookButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.bookButton.isSelected = false
            self.bookButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
    // Gear Button
    
    @IBAction func gearButton(_ sender: Button) {
        if self.gearButton.isSelected == false {
            self.gearButton.backgroundColor = Colors.blue.light2
            self.gearButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.gearButton.isSelected = true
        } else {
            self.gearButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.gearButton.isSelected = false
            self.gearButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
    // Electronics Button
    
    @IBAction func electronicsButton(_ sender: RaisedButton) {
        if self.electronicsButton.isSelected == false {
            self.electronicsButton.backgroundColor = Colors.blue.light2
            self.electronicsButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.electronicsButton.isSelected = true
        } else {
            self.electronicsButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.electronicsButton.isSelected = false
            self.electronicsButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
    // Sports Button
    
    @IBAction func sportsButton(_ sender: RaisedButton) {
        if self.sportsButton.isSelected == false {
            self.sportsButton.backgroundColor = Colors.blue.light2
            self.sportsButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.sportsButton.isSelected = true
        } else {
            self.sportsButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.sportsButton.isSelected = false
            self.sportsButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
    
    // Furniture Button
    
    @IBAction func furnitureButton(_ sender: RaisedButton) {
        if self.furnitureButton.isSelected == false {
            self.furnitureButton.backgroundColor = Colors.blue.light2
            self.furnitureButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.furnitureButton.isSelected = true
        } else {
            self.furnitureButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.furnitureButton.isSelected = false
            self.furnitureButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
    // Other Button
    
    @IBAction func otherButton(_ sender: RaisedButton) {
        if self.otherButton.isSelected == false {
            self.otherButton.backgroundColor = Colors.blue.light2
            self.otherButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.otherButton.isSelected = true
        } else {
            self.otherButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.otherButton.isSelected = false
            self.otherButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
}


