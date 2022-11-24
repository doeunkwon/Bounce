//
//  StyleManager.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-11-24.
//

import UIKit

class StyleManager {
    
    func styleButton(_ button: UIButton, _ title: String) {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 26.0)]
        button.setAttributedTitle(NSAttributedString(string: title, attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
}
