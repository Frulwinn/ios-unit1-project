import Foundation
//key=API_KEY
//api key AIzaSyA1ORJpsHhRC6CENB3wnq02Mb62w2KrWao

class Model {
    
    //singleton
    static let shared = Model()
    private init () {}
    
    //URL for api
    private let url = URL(string: "https://www.googleapis.com/books/v1/mylibrary/bookshelves")!
    private let key = "AIzaSyA1ORJpsHhRC6CENB3wnq02Mb62w2KrWao"
    //var
    var book: Book?
    var books: [Book] = []
    
    //count
    func numberOfBooks() -> Int {
        return books.count
    }
    
    //access book at index
    func book(at indexPath: IndexPath) -> Book {
        return books[indexPath.row]
    }
    
    //add
    func addBook(book: Book) {
        books.append(book)
    }
    
    //delete
    func deleteBook(at indexPath: IndexPath) {
        books.remove(at: indexPath.row)
    }
    
    //update
    func updateBook(at indexPath: IndexPath) {
        let book = books[indexPath.row]
    }
    
    //accessing api process
    func search(for searchTerm: String, completion: @escaping (Book?, Error?) -> Void ) {
        
        let requestURL = url.appendingPathComponent(searchTerm)
        
        //put together a url (for URLRequest) to make a dataTask with
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let clientIDQueryItem = URLQueryItem(name: "API_KEY", value: key)
        let searchQueryItem = URLQueryItem(name: "q", value: searchTerm)
        components?.queryItems = [clientIDQueryItem, searchQueryItem]
        
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
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let book = try jsonDecoder.decode(Book.self, from: data)
                self.book = book
                print("\(book)")
                completion(book, nil)
                
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
}
