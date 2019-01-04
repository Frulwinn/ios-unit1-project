import Foundation


struct BookItem: Codable {
//    var isRead: Bool = false
    
    let items: [Book]
    
    struct Book: Codable {
        let volumeInfo: VolumeInfo

        struct VolumeInfo: Codable {
            let title: String
            let authors: [String]?
            let imageLinks: ImageLink
        
            struct ImageLink: Codable {
                let smallThumbnail: String
                let thumbnail: String
            }
        }
    }
}


