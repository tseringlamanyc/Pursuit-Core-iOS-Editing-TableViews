import UIKit

class CreateShoppingItemViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var priceLabel: UITextField!
        
    // MARK: - IBActions
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
