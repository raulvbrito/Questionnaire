//
//  Coordinator.swift
//  Questionnaire
//
//  Created by Raul Brito on 09/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
	
    func start()
}
