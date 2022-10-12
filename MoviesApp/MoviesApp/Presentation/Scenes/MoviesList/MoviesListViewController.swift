//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by User on 10/10/22.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moviesListTableView: UITableView!
    
    var viewModel: MoviesListViewModel
    
    init( viewModel: MoviesListViewModel) {
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
        viewModel.getMovies()
        viewModel.movies.observe(on: self) { movies in
            self.moviesListTableView.reloadData()
        }
      
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.value.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return UITableViewCell()
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MoviesItemTableViewCell.reuseIdentifier) as? MoviesItemTableViewCell else {
            return UITableViewCell()
        }
        let movieAtual = viewModel.movies.value[indexPath.row]
        
        movieCell.adicionarInformacaoMovie(titulo: movieAtual.titulo, ano: movieAtual.ano)
        return movieCell
        
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
