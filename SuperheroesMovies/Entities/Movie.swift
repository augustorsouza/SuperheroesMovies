import Foundation

struct Movie: Codable {
    let title: String
    let coverUrl: String
    let director: String
    let year: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case coverUrl = "Poster"
        case director = "Director"
        case year = "Year"
    }
}
