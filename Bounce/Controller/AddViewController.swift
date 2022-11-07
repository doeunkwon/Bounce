//
//  AddViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-10-01.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var daytimeLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var daytimeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLabel.text = "Add"
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 25.0)]
    
        addButton.setAttributedTitle(NSAttributedString(string: "Add", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        
    }
    
}
