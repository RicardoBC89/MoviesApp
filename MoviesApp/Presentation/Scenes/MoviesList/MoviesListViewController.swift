//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by User on 10/10/22.
//

import UIKit

final class MoviesListViewController: EmptyStateDisplayable {
    
    override var viewQueEuQueroQueColoqueOEmptyView: UIView {
        view
    }
    
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
        viewModel.fetchMovies(pagina: 1)
        setUpBindings()
        emptyStateView.onTryAgainAction = { [weak self] in
            self?.viewModel.fetchMovies(pagina: 1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
        title = "movie_list_screen_title".localized
    }
    
    func setUpBindings() {
        viewModel.movies.observe(on: self) { [weak self] movies in
            guard let self = self else { return }
            if movies.isEmpty {
                self.showEmptyState()
            } else {
                self.hideEmptyState()
            }
            self.moviesListTableView.reloadData()
        }
        viewModel.errorObservable.observe(on: self) { error in
            guard let error = error as? NetworkError else {return}
            let action = UIAlertAction(title: "ok".localized, style: .default, handler: nil)
            let popUp = UIAlertController(title: "error".localized, message: error.errorDescripition, preferredStyle: UIAlertController.Style.alert)
            popUp.addAction(action)
            self.present(popUp, animated: true, completion: nil)
        }
        viewModel.isLoading.observe(on: self) { [weak self] shouldShowLoading in
            guard let self = self else { return }
            if shouldShowLoading, self.viewModel.movies.value.isEmpty {
                LoadingOverlay.shared.showOverlay(view: self.view)
            } else {
                LoadingOverlay.shared.hideOverlayView()
            }
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
        if indexPath.row == viewModel.movies.value.count - 5 {
            viewModel.nextPage()
        }
        return movieCell
    }
}
