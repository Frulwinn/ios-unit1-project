import Foundation


class BookItem: Codable, FirebaseItem {
    
    var recordIdentifier = ""
    var isRead : Bool = false
    
    var items: [Book]
    
    struct Book: Codable {
        var volumeInfo: VolumeInfo

        struct VolumeInfo: Codable {
            var title: String
            var authors: String //[String]?
            var imageLinks: ImageLink
        
            struct ImageLink: Codable {
                var smallThumbnail: String
                var thumbnail: String
            }
        }
    }
    //need to initialize since class
    init(title: String, authors: String, thumbnail: String) {
        self.items[0].volumeInfo.title = title
        self.items[0].volumeInfo.authors = authors
        self.items[0].volumeInfo.imageLinks.thumbnail = thumbnail
    }
}


