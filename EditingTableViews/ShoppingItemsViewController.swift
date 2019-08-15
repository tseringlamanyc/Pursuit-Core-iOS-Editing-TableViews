import UIKit

class ShoppingItemsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var shoppingItemsTableView: UITableView!
    
    // MARK: - Private properties
    
    private var shoppingItems = [ShoppingItem]()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureShoppingItemsTableView()
        loadShoppingItems()
    }
    
    // MARK: - IBActions
    
    @IBAction func toggleEditMode(_ sender: UIButton) {
        switch shoppingItemsTableView.isEditing {
        case true:
            shoppingItemsTableView.setEditing(false, animated: true)
            sender.setTitle("Edit", for: .normal)
        case false:
            shoppingItemsTableView.setEditing(true, animated: true)
            sender.setTitle("Stop Editing", for: .normal)
        }
    }
    
    // MARK: - Private Methods
    
    private func loadShoppingItems() {
        let allItems = ShoppingItemFetchingClient.getShoppingItems()
        shoppingItems = allItems
    }
    
    private func configureShoppingItemsTableView() {
        shoppingItemsTableView.dataSource = self
        shoppingItemsTableView.delegate = self
    }
}

extension ShoppingItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = shoppingItemsTableView.dequeueReusableCell(withIdentifier: "shoppingItemCell") else {
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
