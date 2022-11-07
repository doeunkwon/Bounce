//
//  scheduleViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-10-07.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var scheduleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleLabel.text = "Schedule"
        
    }
}
