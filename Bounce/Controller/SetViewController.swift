//
//  SetViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-10-01.
//

import UIKit

class SetViewController: UIViewController {
    
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var bedtimeLabel: UILabel!
    @IBOutlet weak var bedtimeSlider: UISlider!
    @IBOutlet weak var setButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabel.text = "Set"
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 25.0)]
    
        setButton.setAttributedTitle(NSAttributedString(string: "Set", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        
    }
    
}
