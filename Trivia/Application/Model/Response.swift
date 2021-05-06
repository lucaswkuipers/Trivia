//
//  Response.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 05/05/2021.
//

import Foundation

// MARK: - Response
struct Response: Codable {
	let responseCode: Int
	let results: [Question]

	enum CodingKeys: String, CodingKey {
		case responseCode = "response_code"
		case results
	}
}
