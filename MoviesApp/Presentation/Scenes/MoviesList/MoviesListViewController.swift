//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by User on 10/10/22.
//

import UIKit

final class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var moviesListTableView: UITableView!
    
    private let viewModel: MoviesListViewModel
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        moviesListTableView.register(MoviesItemTableViewCell.nib, forCellReuseIdentifier: MoviesItemTableViewCell.reuseIdentifier)
        viewModel.fetchMovies()
        viewModel.movies.observe(on: self) { movies in
            self.moviesListTableView.reloadData()
        }
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MoviesItemTableViewCell.reuseIdentifier) as? MoviesItemTableViewCell else {
            return UITableViewCell()
        }
        let movieAtual = viewModel.movies.value[indexPath.row]
        movieCell.adicionarInformacaoMovie(titulo: movieAtual.titulo, ano: movieAtual.ano, caminhoIMG: movieAtual.caminhoIMG)
        return movieCell
    }
}
