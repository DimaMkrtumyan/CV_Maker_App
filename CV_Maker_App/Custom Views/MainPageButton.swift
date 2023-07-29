//
//  MainPageButton.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 25.07.23.
//

import UIKit

final class MainPageButton: UIButton {
    
    private func setup() {
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        self.backgroundColor = .yellow
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.gray, for: .highlighted)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

final class SubmitButton: UIButton {
    
    private func setup() {
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        self.backgroundColor = .yellow
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray.cgColor
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.gray, for: .highlighted)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}
