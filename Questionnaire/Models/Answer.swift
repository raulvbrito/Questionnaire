//
//  Answer.swift
//  Questionnaire
//
//  Created by Raul Brito on 09/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation

// MARK: - Answer

struct Answer: Codable {
	
	let text: String
	let weight: Int
	
	enum CodingKeys: String, CodingKey {
		case text = "text"
		case weight = "weight"
	}
}
