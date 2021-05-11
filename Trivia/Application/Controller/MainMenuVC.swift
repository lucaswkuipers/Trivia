//
//  MainMenuVC.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 07/05/2021.
//

import UIKit

class MainMenuVC: UIViewController {
	
	let screen = MainMenuScreen()

	override func loadView() {
		self.view = screen
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("heeey")
	}
}
