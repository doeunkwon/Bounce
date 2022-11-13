//
//  SetViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-10-01.
//

import UIKit

class SetViewController: UIViewController {
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var bedSlider: UISlider!
    @IBOutlet weak var setButton: UIButton!
    
    var bedValue = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 25.0)]
        
        setButton.setAttributedTitle(NSAttributedString(string: "Set", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
    }
    
    @IBAction func bedSlid(_ sender: UISlider) {
        bedValue = Int(sender.value)
        bedLabel.text = "\(bedValue)pm"
    }
    
}

//MARK: - UITextFieldDelegate

extension SetViewController: UITextFieldDelegate {
    
    // get rid keyboard when user taps elsewhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nicknameTextField.endEditing(true)
    }
    
}
