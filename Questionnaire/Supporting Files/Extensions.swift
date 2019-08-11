//
//  Extensions.swift
//  Questionnaire
//
//  Created by Raul Brito on 09/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

extension UIView {
	func cardShadow() {
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 2.5)
		self.layer.shadowOpacity = 0.25
		self.layer.shadowRadius = 2.5
	}
}

extension JSONDecoder {
	open func decode<T>(_ type: T.Type, from resource: String) throws -> T where T : Decodable {
		let decoder = JSONDecoder()
		
		guard let jsonPath = Bundle.main.url(forResource: resource.lowercased(), withExtension: "json") else {
			throw Constants.JSONError.invalidJSONFile
		}
		
		do {
			let jsonData = try Data(contentsOf: jsonPath, options: .mappedIfSafe)
			
			let result = try decoder.decode(type, from: jsonData)
			
			return result
		} catch {
			throw Constants.JSONError.failedToParse
		}
	}
}
