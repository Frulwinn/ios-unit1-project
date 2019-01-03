import Foundation

struct Book: Codable {
    let kind: String
    
    let title: [VolumeInfo]
    struct VolumeInfo: Codable {
        let title: String
    }
    
    let author: [VolumeInfo]
    struct VolumeInfo: Codable {
        let volumeInfo: Authors
        
        struct Authors: Codable {
            let authors: String
        }
    }
    
    let image: [VolumeInfo]
    struct VolumeInfo: Codable {
        let volumeInfo: ImageLinks
        
        struct ImageLinks: Codable {
            let imageLinks: String
        }
    }
}
