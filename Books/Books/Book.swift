import Foundation


struct BookItem: Codable {
    
    let items: [Book]
    
    struct Book: Codable {
        let volumeInfo: VolumeInfo

        struct VolumeInfo: Codable {
            let title: String
            let authors: [String]?
            let imageLinks: ImageLink?
        
            struct ImageLink: Codable {
                let smallThumbnail: String
                let thumbnail: String
            }
        }
    }
}


