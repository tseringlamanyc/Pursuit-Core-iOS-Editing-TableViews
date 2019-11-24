//
//  ShoppingItemsViewController.swift
//  EditingTableViews
//
//  Created by Tsering Lama on 11/23/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShoppingItemsViewController: UIViewController {
    
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var shoppingItems = [ShoppingItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingItems = ShoppingItemFetchingClient.getShoppingItems()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    @IBAction func editPressed(_ sender: UIButton) {
        switch tableView.isEditing {
        case true:
            tableView.setEditing(false, animated: true)
            sender.setTitle("Edit", for: .normal)
        case false:
            tableView.setEditing(true, animated: false)
            sender.setTitle("Stop Editing", for: .normal)
        }
    }
}

extension ShoppingItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItemCell") else {
            fatalError("Unknown Reuse ID")
        }
        let shoppingItem = shoppingItems[indexPath.row]
        cell.textLabel?.text = shoppingItem.name
        cell.detailTextLabel?.text = "$\(shoppingItem.price)"
        return cell
    }
}


extension ShoppingItemsViewController: UITableViewDelegate {
    
}
