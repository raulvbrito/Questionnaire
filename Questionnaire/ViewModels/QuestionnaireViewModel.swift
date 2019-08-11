//
//  QuestionnaireViewModel.swift
//  Questionnaire
//
//  Created by Raul Brito on 09/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation
import UIKit

class QuestionnaireViewModel {
	
	// MARK: - Properties
	
	let service: QuestionnaireServiceProtocol
	
	var questionCellViewModels: [QuestionCellViewModel] = [QuestionCellViewModel]() {
		didSet {
			self.reloadData?()
		}
	}
	
	var reloadData: (()->())?
	
	var result = 0
	
	var message = "Invalid result!"
	
	
	// MARK: - Methods
	
	init(_ service: QuestionnaireServiceProtocol = QuestionnaireService()) {
		self.service = service
	}
	
	func fetchQuestionnaire() {
		service.fetchQuestionnaire { (error, questions) in
			if let error = error {
				print(error.domain)
				return
			}
			
			self.questionCellViewModels = questions?.map { return QuestionCellViewModel(question: $0) } ?? []
		}
	}

	func evaluate(result: Int) {
		self.result = result
		
		if result >= 0 && result <= 6 {
			self.message = "Unfortunately, we don’t match!"
		} else if result >= 7 && result < 10 {
			self.message = "That looks good!"
		} else if result >= 10 {
			self.message = "Excellent!"
		}
	}
	
	func cellViewModel(at indexPath: IndexPath) -> QuestionCellViewModel {
		return questionCellViewModels[indexPath.row]
	}
}

struct QuestionCellViewModel {
	let text: String
	let answers: [Answer]
	
	init(question: Question) {
		text = question.text
		answers = question.answers
	}
}
