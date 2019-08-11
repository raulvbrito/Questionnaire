//
//  QuestionnaireService.swift
//  Questionnaire
//
//  Created by Raul Brito on 09/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation
import Alamofire

protocol QuestionnaireServiceProtocol {
	func fetchQuestionnaire(completion: @escaping (_ error: NSError?, _ result: [Question]?) -> Void)
}

class QuestionnaireService: QuestionnaireServiceProtocol {
	
	// MARK: - Requests
	
	func fetchQuestionnaire(completion: @escaping (_ error: NSError?, _ result: [Question]?) -> Void) {
		let url = ""
		
		Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).validate().responseData { response in
			
			let decoder = JSONDecoder()
			
			switch response.result {
			case .success(let data):
				do {
					let result = try decoder.decode(Questionnaire.self, from: data)
					
					completion(nil, result.questions)
				} catch {
					completion(NSError(domain: "Failed to parse questionnaire", code: response.response?.statusCode ?? 400, userInfo: nil), nil)
				}
				
				break
			default:
				#if DEBUG
				do {
					let result = try decoder.decode(Questionnaire.self, from: "questionnaire")
					
					completion(nil, result.questions)
				} catch let error {
					completion(error as NSError, nil)
				}
				#endif
			
				completion(NSError(domain: "Failed to fetch questionnaire", code: response.response?.statusCode ?? 400, userInfo: nil), nil)
				break
			}
			
			return
		}
	}
}
