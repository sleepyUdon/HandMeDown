//
//  SecondViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-11-22.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import Material

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    @IBOutlet weak var accessoryButton: RaisedButton!
    @IBOutlet weak var furnitureButton: RaisedButton!
    @IBOutlet weak var otherButton: RaisedButton!
    @IBOutlet weak var pictureView: UIImageView!
    
    // MARK: Set up properties

//    var picture: UIImage? {
//        didSet {
//            let picture = UIImage {
//                let data = **picture from camera**
//                picture = UIImage(data: pictureData)
//            }

    var itemTitle: String?
    var itemDescription: String?
    var category: [String]?
    let picker = UIImagePickerController()

    
            
    // ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self

    }
    

    // ViewWillAppear

    override func viewWillAppear(_ animated: Bool) {
        
        // set up buttons
        
        boyButton.isSelected = false
        girlButton.isSelected = false
        babyButton.isSelected = false
        toddlerButton.isSelected = false
        kidButton.isSelected = false
        tweenButton.isSelected = false
        teenButton.isSelected = false
        clothesButton.isSelected = false
        toyButton.isSelected = false
        bookButton.isSelected = false
        gearButton.isSelected = false
        electronicsButton.isSelected = false
        sportsButton.isSelected = false
        accessoryButton.isSelected = false
        furnitureButton.isSelected = false
        otherButton.isSelected = false
    }
    
    
// Actions
    
    
    // Handle Post Button
    
    @IBAction func HandlePostButton(_ sender: UIButton) {
        
    }
    
    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
    
    // MARK: Handle Add Picture Button
    
    @IBAction func HandleAddPictureButton(_ sender: UIButton) {
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
//        picker.allowsEditing = true
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
        pictureView.image = pickedImage
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
            self.boyButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            self.boyButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.boyButton.isSelected = true
        } else {
            self.boyButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.boyButton.isSelected = false
            self.boyButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
    // Girl Button

    @IBAction func girlButton(_ sender: RaisedButton) {
        if self.girlButton.isSelected == false {
            self.girlButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.babyButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.toddlerButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.kidButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.tweenButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.teenButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.clothesButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.toyButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.bookButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.gearButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.electronicsButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.sportsButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            self.sportsButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.sportsButton.isSelected = true
        } else {
            self.sportsButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.sportsButton.isSelected = false
            self.sportsButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
    // Accessory Button
    
    @IBAction func accessoryButton(_ sender: RaisedButton) {
        if self.accessoryButton.isSelected == false {
            self.accessoryButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            self.accessoryButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.accessoryButton.isSelected = true
        } else {
            self.accessoryButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.accessoryButton.isSelected = false
            self.accessoryButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
    // Furniture Button
    
    @IBAction func furnitureButton(_ sender: RaisedButton) {
        if self.furnitureButton.isSelected == false {
            self.furnitureButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
            self.otherButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            self.otherButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.otherButton.isSelected = true
        } else {
            self.otherButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.otherButton.isSelected = false
            self.otherButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
    }
    
    
}


