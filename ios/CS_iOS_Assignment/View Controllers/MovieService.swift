//
//  MovieService.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 Backbase. All rights reserved.
//

import Foundation

class MovieService {
    
    let movieUrl = "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=undefined&api_key=55957fcf3ba81b137f8fc01ac5a31fb5"
    let configUrl = "https://api.themoviedb.org/3/configuration?language=en-US&api_key=55957fcf3ba81b137f8fc01ac5a31fb5"

    let defaultSession = URLSession(configuration: .default)
    let configurationSession = URLSession(configuration: .default)
    
    var configDataTask: URLSessionDataTask?
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
        
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
    
    func fetchConfiguration(completion: @escaping ([String: Any]?) -> Void) {
        configDataTask?.cancel()
        
        guard let url = URL(string: movieUrl) else {
            return
        }
        
        configDataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
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
                
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }
        
        configDataTask?.resume()
    }
}
