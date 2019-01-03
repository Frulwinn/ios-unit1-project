import Foundation

struct Book: Codable {
    let kind: String
    let author: String
    
    let title: [VolumeInfo]
    struct VolumeInfo: Codable {
        let title: String
    }
    
    let image: [ImageLinks]
    struct ImageLinks: Codable {
        let previewLink: String
    }
}
