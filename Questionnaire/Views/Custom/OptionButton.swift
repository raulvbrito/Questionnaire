//
//  OptionButton.swift
//  Questionnaire
//
//  Created by Raul Brito on 10/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

class OptionButton: UIButton {

    override func draw(_ rect: CGRect) {
		self.setTitleColor(.black, for: .normal)
		self.setTitleColor(.white, for: .selected)
		self.contentHorizontalAlignment = .leading
		self.contentEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 40)
		self.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
		self.titleLabel?.numberOfLines = 0
		self.layer.cornerRadius = 8
    }

}
