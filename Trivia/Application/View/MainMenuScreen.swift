//
//  MainMenuView.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 07/05/2021.
//

import UIKit

final class MainMenuScreen: UIView {
	
	var button: UIButton = {
		let view = UIButton(frame: .zero)
		view.backgroundColor = .red
		view.setTitle("PLAY", for: .normal)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
		
	// MARK: - Initialization
	
	override init(frame: CGRect = .zero) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Conforming to CodeView

extension MainMenuScreen: CodeView {
	func buildViewHierarchy() {
		addSubview(button)
	}
	
	func setupConstraints() {
		button.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		button.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
	}
	
	func setupAdditionalConfiguration() {
//		backgroundColor = .red
	}
	
	func setupView() {
		buildViewHierarchy()
		setupConstraints()
		setupAdditionalConfiguration()
	}
}
