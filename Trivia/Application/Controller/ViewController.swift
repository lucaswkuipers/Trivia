//
//  ViewController.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 01/05/2021.
//

import UIKit

final class ViewController: UIViewController {
	
	@IBAction private func playButtonPressed(_ sender: Any) {
		let questionViewController = QuestionViewController()
		self.navigationController?.pushViewController(questionViewController, animated: true)
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
