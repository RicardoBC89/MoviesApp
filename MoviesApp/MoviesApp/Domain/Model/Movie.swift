
import Foundation

struct Movie: Decodable {
    var titulo: String
    var ano: String
    enum CodingKeys: String, CodingKey {
        case titulo = "title"
        case ano = "release_date"
    }
}

