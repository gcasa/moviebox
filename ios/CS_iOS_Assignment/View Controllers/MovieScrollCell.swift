//
//  MovieScrollCell.swift
//  CS_iOS_Assignment
//
//  Created by Gregory Casamento on 6/8/21.
//  Copyright © 2021 Backbase. All rights reserved.
//
import UIKit

class MovieScrollCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let movieService = MovieService.sharedMovieService
    var playingNowArray: [Any] = []

    @IBOutlet var collectionView : UICollectionView!
    
    //
    // MARK: - Class Constants
    //
    static let identifier = "MovieScrollCell"
    
    func configure()
    {
        self.backgroundColor = UIColor.black
        movieService.fetchMovies { playingNowArray in
            if let playingNowArray = playingNowArray {
                self.playingNowArray = playingNowArray
                self.collectionView.reloadData()
            }
        }
    }
    
    // collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.playingNowArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell",
                                                                              for: indexPath) as! MovieCollectionViewCell
        
        cell.configure(movieDictionary: playingNowArray[indexPath.row] as! [String : Any], baseUrl: movieService.baseUrl(), service: movieService)
        
        return cell
    }
}
