//
//  ViewController.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 Backbase. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var jsonArray: [Any] = []
    var configDict: [String : Any] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let movieService = MovieService.sharedMovieService
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleImage = UIImage(named:"Movie")
        let titleView = UIImageView(image:titleImage)
        self.navigationItem.titleView = titleView
        self.navigationItem.titleView?.backgroundColor = UIColor.black
        
        movieService.fetchConfiguration {
            movieService.fetchPopularMovies { jsonArray in
                if let jsonArray = jsonArray {
                    self.jsonArray = jsonArray
                    self.moviesTableView.reloadData()
                }
            }
        }
    }
    
    // tableview delegate/datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0)
        {
            return 1
        }
        
        return self.jsonArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0)
        {
            return 200.0
        }
        
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0)
        {
            return "Playing Now"
        }
        
        return "Most Popular"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0)
        {
            let cell:MovieScrollCell = tableView.dequeueReusableCell(withIdentifier: "MovieScrollCell",
                                                               for: indexPath) as! MovieScrollCell
            cell.configure()
            cell.backgroundColor = UIColor.black
            return cell
        }
        
        let cell:MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",
                                                           for: indexPath) as! MovieCell
        cell.configure(movieDictionary: jsonArray[indexPath.row] as! [String : Any], baseUrl: movieService.baseUrl(), service: movieService)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MovieDetail", sender: self)
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller : DetailViewController = segue.destination as! DetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: indexPath!) as! MovieCell
        
        controller.movieId = cell.movieId
    }

}
