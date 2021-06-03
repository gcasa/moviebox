//
//  ViewController.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 Backbase. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    var jsonArray: [Any] = []
    var configDict: [String : Any] = [:]
    
    let movieService = MovieService()
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    func fetchMovies() {
        movieService.fetchMovies { jsonArray in
            if let jsonArray = jsonArray {
                self.jsonArray = jsonArray
                self.moviesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        movieService.fetchConfiguration { configDict in
            if let configDict = configDict {
                self.configDict = configDict
                self.fetchMovies()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.jsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",
                                                           for: indexPath) as! MovieCell
        cell.configure(movieDictionary: jsonArray[indexPath.row] as! [String : Any])
        return cell
    }
}
