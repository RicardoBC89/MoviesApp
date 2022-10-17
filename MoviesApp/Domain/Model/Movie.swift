
import Foundation

struct Movie: Decodable {
    var titulo: String
    var ano: String
    let caminhoIMG: String
    enum CodingKeys: String, CodingKey {
        case titulo = "title"
        case ano = "release_date"
        case caminhoIMG = "poster_path"
    }
}

