//
//  DetailViewController.swift
//  CS_iOS_Assignment
//
//  Created by Gregory Casamento on 6/7/21.
//  Copyright © 2021 Backbase. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var genres: UILabel!
    
    var movieId : Int!

    var movieService = MovieService.sharedMovieService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overCurrentContext
        movieService.fetchDetail(movieid: movieId) { jsonDict in
            if let jsonDict = jsonDict {
                let baseUrl : String = self.movieService.baseUrl()
                let posterPath : String = (jsonDict["poster_path"]) as! String
                let imagePath : String = "\(baseUrl)w300\(posterPath)"
                
                self.movieService.fetchImage(view: self.imageView, path: imagePath)
                self.movieTitle.text = (jsonDict["original_title"]) as? String
                self.releaseDate.text = (jsonDict["release_date"]) as? String
                self.runTime.text = (jsonDict["runtime"]) as? String
                self.overviewText.text = (jsonDict["overview"]) as? String
                
                var genreString = "Genres:"
                let genreArray = (jsonDict["genres"]) as? [Any]
                genreArray?.forEach({ g in
                    let genreDict = g as? [String : Any]
                    let s = genreDict?["name"] as? String
                    genreString.append(" ")
                    genreString.append(s!)
                })
                
                self.genres.text = genreString
            }
        }
    }

    @IBAction func doneAction()
    {
        self.dismiss(animated: true) {
        }
    }
}
