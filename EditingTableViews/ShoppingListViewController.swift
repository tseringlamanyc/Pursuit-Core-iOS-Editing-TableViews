import UIKit

class ShoppingListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    
    private var data = [ShoppingItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        data = ShoppingItemFetchingClient.getShoppingItems()
    }
    
    
    @IBAction func startEditing(_ sender: UIButton) {
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

extension ShoppingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItemCell") else {
            fatalError("Unknown Reuse ID")
        }
        let shoppingItem = data[indexPath.row]
        cell.textLabel?.text = shoppingItem.name
        cell.detailTextLabel?.text = "$\(shoppingItem.price)"
        return cell
    }
}

extension ShoppingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            data.remove(at: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
        default:
            break
        }
    }
}
