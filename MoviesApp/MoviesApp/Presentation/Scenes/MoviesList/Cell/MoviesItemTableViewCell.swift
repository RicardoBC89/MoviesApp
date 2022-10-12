//
//  MoviesItemTableViewCell.swift
//  MoviesApp
//
//  Created by User on 10/10/22.
//

import UIKit

class MoviesItemTableViewCell: UITableViewCell {

    @IBOutlet weak var movieAno: UILabel!
    @IBOutlet weak var movieTitulo: UILabel!
    func adicionarInformacaoMovie (titulo: String, ano: Int) {
        movieTitulo.text = titulo
        movieAno.text = String(ano)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
