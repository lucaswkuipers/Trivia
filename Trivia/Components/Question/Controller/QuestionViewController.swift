//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 04/05/2021.
//

import UIKit

final class QuestionViewController: UIViewController {

	// MARK: - IBOutlets
	
	@IBOutlet weak var paddingQuestion: UIView!
	
	// MARK: - IBActions
	
	@IBAction func firstAlternativeButtonPressed(_ sender: UIButton) {
		print(sender.titleLabel?.text!)
	}
	@IBAction func secondAlternativeButtonPressed(_ sender: UIButton) {
	}
	@IBAction func thirdAlternativeButtonPressed(_ sender: UIButton) {
	}
	@IBAction func fourthAlternativeButtonPressed(_ sender: UIButton) {
	}

	// MARK: - View Cycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		fetchData()
		setupUI()
    }
	func fetchData() {
		
	}
	func setupUI() {
		paddingQuestion.layer.cornerRadius = 10
	}
}
