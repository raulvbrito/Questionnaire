//
//  Question.swift
//  Questionnaire
//
//  Created by Raul Brito on 09/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation

// MARK: - Question

struct Question: Codable {
	
	let id: Int
	let text: String
	let answers: [Answer]
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case text = "text"
		case answers = "answers"
	}
}

// MARK: - Questionnaire

struct Questionnaire: Codable {
	
	let questions: [Question]
	
	enum CodingKeys: String, CodingKey {
		case questions = "questionnaire"
	}
}
