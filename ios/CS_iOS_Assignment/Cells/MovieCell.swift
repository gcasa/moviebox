//
//  MovieCell.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 Backbase. All rights reserved.
//

import UIKit

//
// MARK: - Movie Cell
//
class MovieCell: UITableViewCell {
    
    //
    // MARK: - Class Constants
    //
    static let identifier = "MovieCell"
    
    var movieId : Int!
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: RatingView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    func configure(movieDictionary: [String: Any], baseUrl: String, service: MovieService)
    {
        let posterPath : String = (movieDictionary["poster_path"]) as! String
        let imagePath : String = "\(baseUrl)w92\(posterPath)"
        let r = (movieDictionary["vote_average"]) as! Double
        
        // rating.color = UIColor.green
        rating.value = CGFloat(r / 10.0) 
        title.text = (movieDictionary["title"] as! String)
        releaseDate.text = (movieDictionary["release_date"] as? String)
        movieId = (movieDictionary["id"] as! Int)
        
        title.textColor = UIColor.white
        releaseDate.textColor = UIColor.white
        self.backgroundColor = UIColor.black
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        self.selectedBackgroundView = bgColorView
        
        service.fetchImage(view: poster, path: imagePath)
    }
}
