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
    
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doneAction()
    {
        self.dismiss(animated: true) {
        }
    }
}
