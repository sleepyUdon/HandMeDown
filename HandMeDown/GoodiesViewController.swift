//
//  FirstViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-11-22.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import Material

class GoodiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: RaisedButton!
    
    
    fileprivate var itemsDataSource = ItemsDataSource()
    fileprivate let reuseIdentifier = "GoodiesCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareLayout()
    }
    
    // MARK: Prepare Layout
    
    func prepareLayout(){
        self.filterButton.cornerRadius = self.filterButton.frame.height/2
        self.filterButton.backgroundColor = Colors.purple.light1
        self.filterButton.titleLabel?.font = Fonts.button.BT2
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "MasterToDetail" {
//            let detailViewController = segue.destination as! DetailViewController
//            detailViewController.paper = sender as? Paper
//        }
//    }
    
    
    // MARK: CollectionView Cell Size
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 30)/2, height:200)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return itemsDataSource.numberOfSections
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemsDataSource.numberOfItemsInSection(section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodiesCollectionViewCell", for: indexPath) as! GoodiesCollectionViewCell
        
        // Configure the cell
        
        if let item = itemsDataSource.itemForItemAtIndexPath(indexPath) {
            cell.item = item
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
//     func collectionView(_ collectionView: UICollectionView,
//                                 didSelectItemAt indexPath: IndexPath) {
//        if let item = itemsDataSource
//            .itemForItemAtIndexPath(indexPath) {
//            performSegue(withIdentifier: "MasterToDetail", sender: paper)
//        }
    }
    

