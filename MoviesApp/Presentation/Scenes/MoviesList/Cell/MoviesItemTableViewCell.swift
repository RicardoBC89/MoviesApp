//
//  MoviesItemTableViewCell.swift
//  MoviesApp
//
//  Created by User on 10/10/22.
//
import Kingfisher
import UIKit

class MoviesItemTableViewCell: UITableViewCell {

    @IBOutlet weak var movieAno: UILabel!
    @IBOutlet weak var movieTitulo: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func adicionarInformacaoMovie (titulo: String, ano: String, caminhoIMG: String) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        movieTitulo.text = titulo
        movieAno.text = ano.formatDate()
        guard let url = URL (string: AppConfiguration.imageBaseURL+caminhoIMG) else {return}
        posterImageView.kf.setImage(with: url, options: [
            .processor(DownsamplingImageProcessor(size: posterImageView.bounds.size)),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage,
        ]) { [weak self] _ in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
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
