//
//  MyStuffViewController.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-15.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit
import RealmSwift

class MyStuffViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var items = ["John","Bob","Adam"]
    
    /// MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    /// MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    /// MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyStuffCell") as! MyStuffTableViewCell
//        cell.configureWithItem(item: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
//            let realm = try!Realm()
//            try! realm.write {
//                realm.delete(items[indexPath.row])
            }
            tableView.reloadData()
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


