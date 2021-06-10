//
//  MovieCollectionViewCell.swift
//  CS_iOS_Assignment
//
//  Created by Gregory Casamento on 6/8/21.
//  Copyright © 2021 Backbase. All rights reserved.
//

import UIKit

class MovieCollectionViewCell :UICollectionViewCell {
    var movieId : Int!
    
    @IBOutlet var imageView : UIImageView!
    
    func configure(movieDictionary: [String: Any], baseUrl: String, service: MovieService)
    {
        let posterPath : String = (movieDictionary["poster_path"]) as! String
        let imagePath : String = "\(baseUrl)w92\(posterPath)"
        movieId = (movieDictionary["id"] as! Int)
        
        self.backgroundColor = UIColor.black
        service.fetchImage(view: imageView, path: imagePath)
    }}
