//
//  ViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-09-30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greetingLabel.text = "Good Afternoon,"
        nameLabel.text = "Doeun 🧑🏻‍💻"
        placeLabel.text = "Vancouver ☀️ 20°C"
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 26.0)]
    
        blueButton.setAttributedTitle(NSAttributedString(string: "Schedule", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        blueButton.layer.shadowOpacity = 0.1
        blueButton.layer.shadowRadius = 3.0
        blueButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        greenButton.setAttributedTitle(NSAttributedString(string: "Add", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        greenButton.layer.shadowOpacity = 0.1
        greenButton.layer.shadowRadius = 3.0
        greenButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        orangeButton.setAttributedTitle(NSAttributedString(string: "Set", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        orangeButton.layer.shadowOpacity = 0.1
        orangeButton.layer.shadowRadius = 3.0
        orangeButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        redButton.setAttributedTitle(NSAttributedString(string: "Library", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        redButton.layer.shadowOpacity = 0.1
        redButton.layer.shadowRadius = 3.0
        redButton.layer.shadowOffset = CGSize(width: 0, height: 1)
    }


}

