//
//  MovieCollectionViewCell.swift
//  CS_iOS_Assignment
//
//  Created by Gregory Casamento on 6/8/21.
//  Copyright © 2021 Backbase. All rights reserved.
//

import UIKit

class MovieCollectionViewCell :UICollectionViewCell {
    @IBOutlet var imageView : UIImageView!
    
    func configure(movieDictionary: [String: Any], baseUrl: String, service: MovieService)
    {
        let posterPath : String = (movieDictionary["poster_path"]) as! String
        let imagePath : String = "\(baseUrl)w300\(posterPath)"

        service.fetchImage(view: imageView, path: imagePath)
    }}
