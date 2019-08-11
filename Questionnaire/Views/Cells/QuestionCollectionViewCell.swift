//
//  QuestionCollectionViewCell.swift
//  Questionnaire
//
//  Created by Raul Brito on 09/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {

	// MARK: - Properties

	var questionCellViewModel: QuestionCellViewModel? {
		didSet {
			cardView.cardShadow()
			questionLabel.text = questionCellViewModel?.text
		}
	}

	@IBOutlet weak var cardView: UIView!
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var answersStackView: UIStackView!
	@IBOutlet weak var finishButton: UIButton!
}
