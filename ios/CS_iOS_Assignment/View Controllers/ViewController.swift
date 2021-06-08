//
//  ViewController.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 Backbase. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var jsonArray: [Any] = []
    var configDict: [String : Any] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    let movieService = MovieService.sharedMovieService
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieService.fetchConfiguration {
            movieService.fetchMovies { jsonArray in
                if let jsonArray = jsonArray {
                    self.jsonArray = jsonArray
                    self.moviesTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.jsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",
                                                           for: indexPath) as! MovieCell
        
        cell.configure(movieDictionary: jsonArray[indexPath.row] as! [String : Any], baseUrl: movieService.baseUrl(), service: movieService)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MovieDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller : DetailViewController = segue.destination as! DetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: indexPath!) as! MovieCell
        
        controller.movieId = cell.movieId
    }
}
