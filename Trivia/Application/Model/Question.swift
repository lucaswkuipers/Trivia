//
//  Question.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 05/05/2021.
//

import Foundation

// MARK: - Question
struct Question: Codable {
	let category: String
	let type: TypeEnum
	let difficulty: Difficulty
	let question, correctAnswer: String
	let incorrectAnswers: [String]

	enum CodingKeys: String, CodingKey {
		case category, type, difficulty, question
		case correctAnswer = "correct_answer"
		case incorrectAnswers = "incorrect_answers"
	}
}

enum Difficulty: String, Codable {
	case easy = "easy"
	case hard = "hard"
	case medium = "medium"
}

enum TypeEnum: String, Codable {
	case multiple = "multiple"
}

