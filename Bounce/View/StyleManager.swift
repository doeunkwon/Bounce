//
//  StyleManager.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-11-24.
//

import UIKit

class StyleManager {
    
    func styleRoundButton(_ button: UIButton, _ title: String) {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 26.0)]
        button.setAttributedTitle(NSAttributedString(string: title, attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.addTarget(self, action: #selector(heavyTapped), for: .touchUpInside)
    }
    
    func styleTextButton(_ button: UIButton, _ title: String) {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 25.0)]
        button.setAttributedTitle(NSAttributedString(string: title, attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        button.addTarget(self, action: #selector(lightTapped), for: .touchUpInside)
    }
    
    @objc func heavyTapped() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
    }
    
    @objc func lightTapped() {
        let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
    }
    
}
