//
//  ViewController.swift
//  Questionnaire
//
//  Created by Raul Brito on 08/08/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIViewController {

	// MARK: - Properties
	
	weak var coordinator: MainCoordinator?
	
	lazy var viewModel: QuestionnaireViewModel = {
		return QuestionnaireViewModel(QuestionnaireService())
	}()
	
	var collectionView: UICollectionView!
	
	var answerPoints: [Int]!
	
	override var preferredStatusBarStyle : UIStatusBarStyle {
		return .lightContent
	}
	
	
	// MARK: - ViewController Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewControllerSetup()
		collectionViewSetup()
		viewModelSetup()
	}

	
	// MARK: - Methods
	
	private func viewControllerSetup() {		
		self.navigationController?.navigationBar.isHidden = true
	}
	
	private func collectionViewSetup() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		
		collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
		
		let questionCollectionViewCell = UINib(nibName: "QuestionCollectionViewCell", bundle: Bundle(for: type(of: self)))
		
		collectionView.register(questionCollectionViewCell, forCellWithReuseIdentifier: "QuestionCollectionViewCell")
		collectionView.delegate = self
		collectionView.dataSource = self
		
		collectionView.isPagingEnabled = true
		collectionView.backgroundColor = UIColor(red: 21/255, green: 31/255, blue: 45/255, alpha: 1)
		
		view.addSubview(collectionView)
	}
	
	private func viewModelSetup() {
		viewModel.reloadData = { [weak self] () in
			DispatchQueue.main.async {
				self?.collectionView.reloadData()
				
				self?.answerPoints = [Int](repeating: 0, count: self?.viewModel.questionCellViewModels.count ?? 0)
			}
		}
		
		viewModel.fetchQuestionnaire()
	}
	
	@objc func toggleAnswer(_ sender: UIButton) {
		UISelectionFeedbackGenerator().selectionChanged()
		
		sender.isSelected = true
		
		let indexPath = collectionView.indexPathsForVisibleItems[0]
		let questionCell = collectionView.cellForItem(at: indexPath) as? QuestionCollectionViewCell
		
		answerPoints[indexPath.item] = sender.tag
		
		for option in questionCell?.answersStackView.subviews as? [OptionButton] ?? [] {
			if option != sender {
				option.isSelected = false
			}

			UIView.animate(withDuration: 0.3) {
				option.layer.backgroundColor = option.isSelected ? UIColor(red: 41/255, green: 164/255, blue: 201/255, alpha: 1).cgColor : UIColor.white.cgColor
			}
		}
	}
	
	@objc func finishQuestionnaire(_ sender: UIButton) {
		viewModel.evaluate(result: answerPoints.reduce(0) { $0 + $1 })
		
		let alert = UIAlertController(title: viewModel.message, message: "", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

		self.present(alert, animated: true)
	}
}


// MARK: - Extensions

extension QuestionnaireViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.questionCellViewModels.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.size.width, height: view.frame.size.height - 100)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCollectionViewCell", for: indexPath) as? QuestionCollectionViewCell
		
		cell?.questionCellViewModel = viewModel.cellViewModel(at: indexPath)
		
		if cell?.answersStackView.subviews.count == 0 {
			for answer in cell?.questionCellViewModel?.answers ?? [] {
				let optionButton = OptionButton(frame: CGRect(x: 0, y: 0, width: cell?.answersStackView.frame.width ?? 0, height: 64))
			
				optionButton.setTitle(answer.text, for: .normal)
				optionButton.tag = answer.weight
				optionButton.addTarget(self, action: #selector(toggleAnswer(_:)), for: .touchUpInside)
			
				cell?.answersStackView.addArrangedSubview(optionButton)
			}
		}
		
		cell?.finishButton.isHidden = indexPath.row == viewModel.questionCellViewModels.count - 1 ? false : true
		cell?.finishButton.addTarget(self, action: #selector(finishQuestionnaire(_:)), for: .touchUpInside)
		
		return cell!
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		
	}
}

