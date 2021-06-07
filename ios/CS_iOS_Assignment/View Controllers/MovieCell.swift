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
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: RatingView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    func configure(movieDictionary: [String: Any], baseUrl: String, service: MovieService)
    {
        var posterPath : String
        var imagePath : String
        title.text = (movieDictionary["title"] as! String)
        releaseDate.text = (movieDictionary["release_date"] as! String)
        posterPath = (movieDictionary["poster_path"]) as! String
        imagePath = "\(baseUrl)w300\(posterPath)"
        service.fetchImage(view: poster, path: imagePath)
    }
}
