//
//  ItemsDataSource.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-07.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import Foundation

class ItemsDataSource {
    
    fileprivate var items: [Item] = []
    fileprivate var immutablePapers: [Item] = []
    fileprivate var sections: [String] = []
    
    var count: Int {
        return items.count
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    // MARK: Public
    
    init() {
        items = loadItemsFromDisk()
        immutablePapers = items
    }
    
    

    
    func indexPathForItem(_ item: Item) -> IndexPath {
        let section = sections.index(of: item.category)!
        var itemID = 0
        for (index, currentItem) in itemsForSection(section).enumerated() {
            if currentItem === item {
                itemID = index
                break
            }
        }
        return IndexPath(item: itemID, section: section)
    }
    
    
    func numberOfItemsInSection(_ index: Int) -> Int {
        let items = itemsForSection(index)
        return items.count
    }
    
    func itemForItemAtIndexPath(_ indexPath: IndexPath) -> Item? {
        if indexPath.section > 0 {
            let items = itemsForSection(indexPath.section)
            return items[indexPath.item]
        } else {
            return items[indexPath.item]
        }
    }
    
    
    // MARK: Private
    
    fileprivate func absoluteIndexForIndexPath(_ indexPath: IndexPath) -> Int {
        var index = 0
        for i in 0..<indexPath.section {
            index += numberOfItemsInSection(i)
        }
        index += indexPath.item
        return index
    }
    
    fileprivate func loadItemsFromDisk() -> [Item] {
        sections.removeAll(keepingCapacity: false)
        if let path = Bundle.main.path(forResource: "Items", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                var items: [Item] = []
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let title = dict["title"] as! String
                        let itemDescription = dict["itemDescription"] as! String
                        let image = dict["image"] as! String
                        let like = dict["image"] as! String
                        let category = dict["category"] as! String
                        let item = Item(title: title, itemDescription: itemDescription, image: image, like: like, category: category)
                        if !sections.contains(category) {
                            sections.append(category)
                        }

                        items.append(item)
                    }
                }
                return items
            }
        }
        return []
    }
    
    fileprivate func itemsForSection(_ index: Int) -> [Item] {
        let section = sections[index]
        let itemsInSection = items.filter { (item: Item) -> Bool in
            return item.category == section
        }
        return itemsInSection
    }
    
}
