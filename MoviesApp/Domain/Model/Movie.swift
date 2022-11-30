import Foundation
import SwiftyUserDefaults

struct Movie: Codable {
    var id: Int
    var titulo: String
    var ano: String
    let caminhoIMG: String
    let adult: Bool
    
    init(id: Int = UUID().uuidString.hash, titulo: String, ano: String, caminhoIMG: String, adult: Bool = false) {
        self.id = id
        self.titulo = titulo
        self.ano = ano
        self.caminhoIMG = caminhoIMG
        self.adult = adult
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case titulo = "title"
        case ano = "release_date"
        case caminhoIMG = "poster_path"
        case adult = "adult"
    }
}

extension Movie: DefaultsSerializable {}
