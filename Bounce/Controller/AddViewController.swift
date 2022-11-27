//
//  AddViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-10-01.
//

import UIKit

class AddViewController: UIViewController {
    
    let coreDataManager = CoreDataManager()
    let styleManager = StyleManager()
    
    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var daySlider: UISlider!
    @IBOutlet weak var addButton: UIButton!
    
    var timeValue = 3
    var dayValue = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleManager.styleTextButton(addButton, "Add")
    }
    
    @IBAction func timeSlid(_ sender: UISlider) {
        timeValue = Int(sender.value)
        timeLabel.text = "\(timeValue)h"
    }
    
    @IBAction func daySlid(_ sender: UISlider) {
        dayValue = Int(sender.value)
        adjustDayLabel(dayValue)
    }
    
    @IBAction func addPressed(_ sender: Any) {
        if let eventInput = eventTextField.text {
            if eventInput != "" {
                let newEvent = Event(context: coreDataManager.context)
                newEvent.event = eventInput
                newEvent.time = Int32(timeValue)
                newEvent.day = Int32(dayValue)
                coreDataManager.save()
                navigationController?.popViewController(animated: true)
                dismiss(animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Hold on!", message: "Please enter an event.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Sure", style: .default, handler: nil))
                present(alert, animated: true)
            }
        }
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
