//
//  MovieService.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 Backbase. All rights reserved.
//

import Foundation
import UIKit

class MovieService {
    
    let movieUrl = "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=undefined&api_key=55957fcf3ba81b137f8fc01ac5a31fb5"
    let configUrl = "https://api.themoviedb.org/3/configuration?language=en-US&api_key=55957fcf3ba81b137f8fc01ac5a31fb5"

    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var imageTask: URLSessionDataTask?
    var errorMessage = ""
    var config: [String: Any] = [:]
    
    func convertToDictionary(text: String) -> [String: Any] {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return [:]
    }

    func fetchMovies(completion: @escaping ([Any]?) -> Void) {
        dataTask?.cancel()
        
        guard let url = URL(string: movieUrl) else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data {
                
                var response: [String: Any]?
                
                do {
                  response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch _ as NSError {
                  return
                }
                
                guard let array = response!["results"] as? [Any] else {
                  return
                }
                
                DispatchQueue.main.async {
                    completion(array)
                }
            }
        }
        
        dataTask?.resume()
    }
    
    func fetchImage(view: UIImageView, path: String) {
        imageTask?.cancel()
        
        guard let url = URL(string: path) else {
            return
        }
        
        imageTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data {
                
                let image: UIImage  = UIImage(data: data)!
                DispatchQueue.main.async{
                    view.image = image
                }
            }
        }
        
        imageTask?.resume()
    }
        
    func fetchConfiguration(completion: () -> Void) {
        let url = URL(string: configUrl)
        let semaphore = DispatchSemaphore(value: 0)
                
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            self.config = self.convertToDictionary(text: String(data: data!, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        completion()
    }
    
    func baseUrl() -> String
    {
        let dict = self.config["images"] as! [String : Any]
        let value = dict["base_url"] as! String
        return value
    }
    
    func poster_sizes() -> [String]
    {
        let dict = self.config["images"] as! [String : Any]
        let value = dict["poster_sizes"] as! [String]
        return value
    }
}
