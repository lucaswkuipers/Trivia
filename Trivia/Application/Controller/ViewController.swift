//
//  ViewController.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 01/05/2021.
//

import UIKit

final class ViewController: UIViewController {
	
	@IBAction private func playButtonPressed(_ sender: Any) {
		let questionViewController = UINib(nibName: "QuestionViewController", bundle: nil).instantiate(withOwner: self, options: nil).first as! QuestionViewController
		self.navigationController?.pushViewController(questionViewController, animated: true)
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
