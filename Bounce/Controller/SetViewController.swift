//
//  SetViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-10-01.
//

import UIKit
import CoreData

class SetViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var sleepSlider: UISlider!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var bedSlider: UISlider!
    @IBOutlet weak var setButton: UIButton!
    
    var preferenceArray = [Preference]()
    
    var sleepValue = 8
    var bedValue = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPreference()
        
        nicknameTextField.delegate = self
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 25.0)]
        
        setButton.setAttributedTitle(NSAttributedString(string: "Set", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        
        if preferenceArray.count == 1 { // "if preference is set"
            nicknameTextField.text = preferenceArray[0].nickname
            sleepValue = Int(preferenceArray[0].sleep)
            sleepSlider.value = Float(sleepValue)
            sleepLabel.text = "\(sleepValue)h"
            bedValue = Int(preferenceArray[0].bed - 12)
            bedSlider.value = Float(bedValue)
            bedLabel.text = "\(bedValue)pm"
        }
        
    }
    
    @IBAction func sleepSlid(_ sender: UISlider) {
        sleepValue = Int(sender.value)
        sleepLabel.text = "\(sleepValue)h"
    }
    
    @IBAction func bedSlid(_ sender: UISlider) {
        bedValue = Int(sender.value)
        bedLabel.text = "\(bedValue)pm"
    }
    
    @IBAction func setPressed(_ sender: Any) {
        if let nicknameInput = nicknameTextField.text {
            if nicknameInput != "" {
                if preferenceArray.count == 1 { // "if preference is set"
                    context.delete(preferenceArray[0])
                }
                let newPreference = Preference(context: context)
                newPreference.nickname = nicknameInput
                newPreference.bed = Int32(bedValue + 12)
                newPreference.sleep = Int32(sleepValue)
                save()
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Hold on!", message: "Please enter a nickname.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Sure", style: .default, handler: nil))
                present(alert, animated: true)
            }
        }
    }
    
    func loadPreference() {
        let request : NSFetchRequest<Preference> = Preference.fetchRequest()
        do {
            preferenceArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
}

//MARK: - UITextFieldDelegate

extension SetViewController: UITextFieldDelegate {
    
    // get rid keyboard when user taps elsewhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nicknameTextField.endEditing(true)
    }
    
}
