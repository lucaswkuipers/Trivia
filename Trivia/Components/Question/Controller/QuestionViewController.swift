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
	let correctAnswer: String
	let allAnswers: [String]
	
	
	public init(questionObj: Question) {
		self.questionText = questionObj.question
		self.difficulty = questionObj.difficulty.rawValue
		self.correctAnswer = questionObj.correctAnswer
		self.allAnswers = questionObj.incorrectAnswers + [correctAnswer]
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
	var currentIndex: Int!
	
	// MARK: - Init
	public init(currentIndex: Int){
		super.init(nibName: "QuestionViewController", bundle: Bundle(for: QuestionViewController.self))
		self.questionViewModel = fetchData(currentIndex: currentIndex)
		self.currentIndex = currentIndex
	}
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }
	
	
	// MARK: - Functionality
	func setupUI() {
		setupQuestion()
		setupAlternatives()
	}
	
	func fetchData(currentIndex: Int) -> QuestionViewModel {
		
		let allQuestions = QuestionsProvider.getQuestions()
		print(allQuestions)
		
		let questionSelected = allQuestions[currentIndex]
		
		let questionVM = QuestionViewModel(questionObj: questionSelected)
		
		return questionVM
	}
	func setupQuestion() {
		
		setupBackground()
		setupDynamicData()
	}
	func setupBackground() {
		questionContainer.layer.cornerRadius = QuestionLayoutConstants.cornerRadius
	}
	func setupDynamicData() {
		let questionText = questionViewModel.questionText
		questionLabel.text = questionText
	}
	
	@objc func buttonClicked(_ sender: UIButton) {
		
		let correctAnswer = questionViewModel.correctAnswer

		guard let alternativeAnswer = sender.titleLabel?.text else {
			return
		}
		if alternativeAnswer == correctAnswer {
			sender.backgroundColor = .green
		} else {
			sender.backgroundColor = .red
		}
		
		goToNextQuestion()
	}
	
	func goToNextQuestion() {
		let questionViewController = QuestionViewController(currentIndex: currentIndex + 1)
		self.navigationController?.pushViewController(questionViewController, animated: true)
	}
	
	func setupAlternatives() {
		
		let alternativesReturned = questionViewModel.allAnswers
		
		var alternatives = alternativesReturned
		
		alternatives.shuffle()
		
		for alternativeText in alternatives {
			
			let container = UIView()
			
			let button = UIButton.init(type: .system)
			button.backgroundColor = UIColor(named: "AccentColor")
			button.setTitleColor(.label, for: .normal)
			button.titleLabel?.font = TriviaAppUIConstants.alternativeFont
			button.setTitle(alternativeText, for: .normal)
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
}
