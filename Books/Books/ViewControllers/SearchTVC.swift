import UIKit

class SearchTVC: UITableViewController, UISearchBarDelegate {
    
    var bookItem: BookItem?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.reloadData()
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

        //let searchResult = Model.shared.bookItem(at: indexPath)
        let searchResult = Model.shared.bookItems[indexPath.row]
        cell.textLabel?.text = searchResult.items[0].volumeInfo.title

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
