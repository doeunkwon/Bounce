//
//  AddViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-10-01.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var daySlider: UISlider!
    @IBOutlet weak var addButton: UIButton!
    
    
    var timeValue = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 25.0)]
    
        addButton.setAttributedTitle(NSAttributedString(string: "Add", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        
    }
    
    @IBAction func timeSlid(_ sender: UISlider) {
        timeValue = Int(sender.value)
        timeLabel.text = "\(timeValue)h"
    }
    
    @IBAction func daySlid(_ sender: UISlider) {
        let dayValue = Int(sender.value)
        adjustDayLabel(dayValue)
    }
    
    func adjustDayLabel(_ dayValue: Int) {
        switch dayValue {
        case 0:
            dayLabel.text = "early"
        case 1:
            dayLabel.text = "noon"
        case 2:
            dayLabel.text = "late"
        default:
            dayLabel.text = "noon"
        }
    }
    
}

//MARK: - UITextFieldDelegate

extension AddViewController: UITextFieldDelegate {
    
    // get rid keyboard when user taps elsewhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        eventTextField.endEditing(true)
    }
    
}
