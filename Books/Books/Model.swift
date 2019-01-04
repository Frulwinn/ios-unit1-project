import Foundation

class Model {
    
    //singleton
    static let shared = Model()
    private init () {}
    
    //var
    var bookItem: BookItem?
    var bookItems: [BookItem] = []
    
    //count
    func numberOfBooks() -> Int {
        return bookItems.count
    }
    
    //access book at index
    func bookItem(at indexPath: IndexPath) -> BookItem {
        return bookItems[indexPath.row]
    }
    
    //add
    func add(bookItem: BookItem, completion: @escaping () -> Void) {
        bookItems.append(bookItem)
        
        Firebase<BookItem>.save(item: bookItem) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
    }
    
    //delete
    func deleteBook(at indexPath: IndexPath, completion: @escaping () -> Void) {
        let bookItem = bookItems[indexPath.row]
        //in local model
        bookItems.remove(at: indexPath.row)
        
        //in firebase
        Firebase<BookItem>.delete(item: bookItem) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
    }
    
    //update
    func updateBook(for bookItem: BookItem, completion: @escaping () -> Void) {
        //in local model
        //let bookItem = bookItems[indexPath.row]
        
        //in firebase
        Firebase<BookItem>.save(item: bookItem) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
    }
    
    //allow my button to change
    func tappedIsRead(for book: BookItem) {
        bookItem?.isRead = !bookItem!.isRead
    }
    
    //URL for api
    private let url = URL(string: "https://www.googleapis.com/books/v1/volumes")!
    
    //accessing api process
    func search(for searchTerm: String, completion: @escaping (BookItem?, Error?) -> Void ) {
        
    
        
        //put together a url (for URLRequest) to make a dataTask with
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
//        let clientIDQueryItem = URLQueryItem(name: "API_KEY", value: key)
        let searchQueryItem = URLQueryItem(name: "q", value: "\(searchTerm)+terms")
        components?.queryItems = [searchQueryItem]
        
        guard let requestURL = components?.url else {
            NSLog("Error requesting Url with \(searchTerm)")
            completion(nil, NSError())
            return
        }
        //create get request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        //fetching data
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was a problem getting data from JSON: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("No data found")
                completion(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
            
                
                let bookItem = try jsonDecoder.decode(BookItem.self, from: data)
                self.bookItem = bookItem
                print("\(bookItem)")
                completion(bookItem, nil)
                
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
}
