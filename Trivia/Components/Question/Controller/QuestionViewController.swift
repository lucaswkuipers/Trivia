//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 04/05/2021.
//

import UIKit

// MARK: - Constants

struct QuestionLayoutConstants {
	static let cornerRadius: CGFloat = 10.0
}

struct TriviaAppUIConstants {
	static let questionFont = UIFont(name: "Avenir Next Bold", size: 26)
	static let alternativeFont = UIFont(name: "Avenir Next Medium", size: 20)
}


// MARK: - View Models

struct QuestionViewModel{
	
	let questionText: String
	let difficulty: String
	let correct_answer: String
	let all_answers: [String]
	
	
	public init(questionText: String, difficulty: String, correct_answer: String,  incorrect_answers: [String]) {
		self.questionText = questionText
		self.difficulty = difficulty
		self.correct_answer = correct_answer
		self.all_answers = incorrect_answers + [correct_answer]
	}
}


// MARK: - Controller

final class QuestionViewController: UIViewController {
	
	// MARK: - IBOutlets
	
	@IBOutlet weak var questionContainer: UIView!
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var stack: UIStackView!
	
	
	// MARK: - Global Variables and Constants
	
	var questionViewModel: QuestionViewModel!

	
	// MARK: - View Cycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }
	
	
	// MARK: - Init
	
	public init(){
		super.init(nibName: "QuestionViewController", bundle: Bundle(for: QuestionViewController.self))
		self.questionViewModel = fetchData()
	}
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Functionality
	
	func fetchData() -> QuestionViewModel {
		
		let questionText = "What is my name? What is my name? What is my name? What is my name?"
		let difficulty = "Hard"
		let correct_answer = "Lucas"
		let incorrect_answers = ["Carlos", "Galdinho", "Coppertone"]
		
		let question = QuestionViewModel(questionText: questionText, difficulty: difficulty, correct_answer: correct_answer, incorrect_answers: incorrect_answers)
		
		return question
	}
	func setupQuestion() {
		questionContainer.layer.cornerRadius = QuestionLayoutConstants.cornerRadius
		questionLabel.text = questionViewModel.questionText
	}
	
	@objc func buttonClicked(_ sender: UIButton) {
		
		let correct = "Lucas"

		guard let name = sender.titleLabel?.text else {
			return
		}
		
		if name == correct {
			sender.backgroundColor = .green
		} else {
			sender.backgroundColor = .red
		}
		
		print(sender.titleLabel?.text)
	}
	
	func setupAlternatives() {
		
		let names = ["Lucas", "Coppertone", "Galdinho", "Carlos"]
		
		for name in names {
			
			let container = UIView()
			
			let button = UIButton.init(type: .system)
			button.backgroundColor = UIColor(named: "AccentColor")
			button.setTitleColor(.label, for: .normal)
			button.titleLabel?.font = TriviaAppUIConstants.alternativeFont
			button.setTitle(name, for: .normal)
			button.addTarget(self, action: #selector(buttonClicked(_ :)), for: .touchUpInside)

			container.addSubview(button)
			
			// Enables auto layout for our button
			button.translatesAutoresizingMaskIntoConstraints = false
			
			button.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
			button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5).isActive = true
			button.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 20).isActive = true
			button.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -20).isActive = true
			
			stack.addArrangedSubview(container)
		}
	}
	func setupUI() {
		setupQuestion()
		setupAlternatives()
	}
}
