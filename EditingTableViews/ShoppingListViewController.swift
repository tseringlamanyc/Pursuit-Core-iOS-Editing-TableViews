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
extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
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
