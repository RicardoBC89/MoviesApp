import Foundation

struct Movie: Decodable {
    var titulo: String
    var ano: String
    let caminhoIMG: String
    let adult: Bool
    
    init(titulo: String, ano: String, caminhoIMG: String, adult: Bool = false) {
        self.titulo = titulo
        self.ano = ano
        self.caminhoIMG = caminhoIMG
        self.adult = adult
    }
    
    enum CodingKeys: String, CodingKey {
        case titulo = "title"
        case ano = "release_date"
        case caminhoIMG = "poster_path"
        case adult = "adult"
    }
}
