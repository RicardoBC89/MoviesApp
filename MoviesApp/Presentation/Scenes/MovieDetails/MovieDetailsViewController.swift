//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by User on 30/11/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var originalTitleLable: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var releseDateLabel: UILabel!
    @IBOutlet weak var movieIdLabel: UILabel!
    private let movieId: String
    
    init(movieId: Int) {
        self.movieId = String(movieId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieIdLabel.text = movieId
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
