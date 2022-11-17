//
//  EventCell.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-11-16.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
