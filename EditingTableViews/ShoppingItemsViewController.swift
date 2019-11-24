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
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard let createItemVC = segue.source as? AddingItemsViewController else {
            fatalError("Unknown segue source")
        }
        if let itemName = createItemVC.nameText.text,
            let itemPriceStr = createItemVC.priceText.text,
            let itemPrice = Double(itemPriceStr) {
            let newItem = ShoppingItem(name: itemName, price: itemPrice)
            shoppingItems.append(newItem)
            let lastRow = tableView.numberOfRows(inSection: 0)
            let lastIndexPath = IndexPath(row: lastRow, section: 0)
            tableView.insertRows(at: [lastIndexPath], with: .automatic)
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            shoppingItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default: break
        }
    }
    
}
