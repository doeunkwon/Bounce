//
//  LibraryViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-10-02.
//

import UIKit

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var libraryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        libraryLabel.text = "Library"
        
    }
    
}
