import UIKit

class SearchTVC: UITableViewController, UISearchBarDelegate {
    
    var bookItem: BookItem?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Firebase<BookItem>.fetchRecords { persons in
            if let bookItem = self.bookItem {
                Model.shared.bookItem = bookItem
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        
        Model.shared.search(for: searchTerm) { (bookItem, error) in
            if let bookItem = bookItem, error == nil {
                self.bookItem = bookItem
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.bookItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)

        let bookItem = Model.shared.bookItem(at: indexPath)
        cell.textLabel?.text = bookItem.items[0].volumeInfo.title

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailBookVC,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let bookItem = Model.shared.bookItem(at: indexPath)
        destination.bookItem = bookItem
    }
}
