//
//  CodeView.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 10/05/2021.
//

import Foundation
protocol CodeView {
	func buildViewHierarchy()
	func setupConstraints()
	func setupAdditionalConfiguration()
	func setupView()
}

extension CodeView {
	func setupView() {
		buildViewHierarchy()
		setupConstraints()
		setupAdditionalConfiguration()
	}
}
