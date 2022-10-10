//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by User on 10/10/22.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
       // tableView.dequeueReusableCell(withIdentifier: <#T##String#>)
    }
    
    @IBOutlet weak var moviesListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        

        
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
