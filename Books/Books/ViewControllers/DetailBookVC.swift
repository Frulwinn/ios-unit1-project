import UIKit

class DetailBookVC: UIViewController {
    
    var bookItem: BookItem?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageLinksView: UIImageView!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var notReadButton: UIButton!
    @IBAction func addToRead(_ sender: Any) {
//        guard let bookItem = bookItem else { return }
//        Model.shared.tappedIsRead(for: bookItem)
//        updateViews()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let bookItem = bookItem else { return }
        guard let title = titleLabel.text, !title.isEmpty else { return }
    }
    
    
    
    func updateViews() {
//        guard let bookItem = bookItem else { return }
        
//        DispatchQueue.main.async {
//        var newButtonTitle: String
//        if bookItem.isRead {
//            newButtonTitle = "Read"
//        } else {
//            newButtonTitle = "Not Read"
//        }
//            self.notReadButton.setTitle(newButtonTitle, for: .normal)
//        }
        
      //  self.navigationItem.title = bookItem.items
    }
}

