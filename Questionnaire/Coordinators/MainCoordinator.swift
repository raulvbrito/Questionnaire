//
//  MainCoordinator.swift
//  Questionnaire
//
//  Created by Raul Brito on 09/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let viewController = QuestionnaireViewController()
		viewController.coordinator = self
		
		navigationController.pushViewController(viewController, animated: false)
	}
}
