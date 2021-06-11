//
//  CS_iOS_AssignmentTests.swift
//  CS_iOS_AssignmentTests
//
//  Created by Vipul Shah on 23/12/2019.
//  Copyright © 2019 Backbase. All rights reserved.
//

import XCTest
@testable import CS_iOS_Assignment

class CS_iOS_AssignmentTests: XCTestCase {

    let movieService = MovieService.sharedMovieService
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMostPopularMovieList() {
        movieService.fetchMovies { jsonArray in
            XCTAssertNotNil(jsonArray)
            let movieDictionary = jsonArray?.first as! [String:Any]
            let title = movieDictionary["title"] as? String
            XCTAssertNotNil(title)
        }
    }

    func testNowPlayingMovieList() {
        movieService.fetchPopularMovies(page: 0) { jsonArray in
            XCTAssertNotNil(jsonArray)
            let movieDictionary = jsonArray?.first as! [String:Any]
            let title = movieDictionary["title"] as? String
            XCTAssertNotNil(title)
        }
    }

    func testConfiguration() {
        movieService.fetchConfiguration {
            XCTAssertNotNil(movieService.config)
            let baseUrl = movieService.baseUrl()
            XCTAssertNotNil(baseUrl)
        }
    }
}
