//
//  ShoppingListViewController.swift
//  EditingTableViews
//
//  Created by David Rifkin on 8/16/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    var shoppingList = [ShoppingItem]()
    @IBOutlet weak var shoppingListTableView: UITableView!
    
    @IBAction func unwind(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        if shoppingListTableView.isEditing {
            shoppingListTableView.setEditing(false, animated: true)
            sender.setTitle("Edit", for: .normal)
            //set it so that it's not editing
        } else {
            shoppingListTableView.setEditing(true, animated: true)
            sender.setTitle("Done", for: .normal)
//            set it so that it is editing
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getShoppingData()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    private func getShoppingData() {
        self.shoppingList = ShoppingItemFetchingClient.getShoppingItems()
    }
    
    private func configureTableView() {
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
    }
    /*
    // MARK: - Navigation

     
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: -- Table View Data Source
extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath)
        
        let selectedITems = shoppingList[indexPath.row]
        cell.textLabel?.text = selectedITems.name
        cell.detailTextLabel?.text = selectedITems.price.description
        return cell
    }
}

//MARK: -- Table View Delegate
extension ShoppingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            shoppingList.remove(at: indexPath.row)
            shoppingListTableView.deleteRows(at: [indexPath], with: .fade)
            print("we hit delete")
        default:
            print("we did something else")
        }
    }
}
