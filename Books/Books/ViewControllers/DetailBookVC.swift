import UIKit

class DetailBookVC: UIViewController {
    
    var bookItem: BookItem?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageLinksView: UIImageView!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var notReadButton: UIButton!
    @IBAction func addToRead(_ sender: Any) {
        guard let bookItem = bookItem else { return }
        Model.shared.addBook(book: bookItem)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let text = reviewTextView.text, !text.isEmpty else { return }
        
        navigationController?.popViewController(animated: true)
    }    
    
    func updateViews() {
        guard let bookItem = bookItem else { return }
        
        navigationItem.title = bookItem.items[0].volumeInfo.title

        titleLabel.text = bookItem.items[0].volumeInfo.title
//        authorLabel.text = bookItem.Book.VolumeInfo.author
//
//        guard let url = URL(string: bookItem.Book.VolumeInfo.thumbnail),
//            let imageData = try? Data(contentsOf: url) else { return }
        
//        imageLinksView.image = UIImage(data: imageData)
        
//        var newButtonTitle: String
//        if bookItem.isRead {
//            newButtonTitle = "Read"
//        } else {
//            newButtonTitle = "Not Read"
//        }
//            self.notReadButton.setTitle(newButtonTitle, for: .normal)
        }

}

