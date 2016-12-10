//
//  FirstViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-11-22.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit

class GoodiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var itemsDataSource = ItemsDataSource()
    fileprivate let reuseIdentifier = "GoodiesCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = collectionView!.frame.width / 2
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width)
        
    }
    

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "MasterToDetail" {
//            let detailViewController = segue.destination as! DetailViewController
//            detailViewController.paper = sender as? Paper
//        }
//    }
    
    
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
    

