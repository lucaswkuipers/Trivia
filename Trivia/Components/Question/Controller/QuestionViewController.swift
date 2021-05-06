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
	static let overlayDistanceToViewTop: CGFloat = 0.0
	static let overlayDistanceToViewBottom: CGFloat = 0.0
	static let overlayDistanceToViewLeft: CGFloat = 0.0
	static let overlayDistanceToViewRight: CGFloat = 0.0
}

struct TriviaAppUIConstants {
	static let questionFont = UIFont(name: "Avenir Next Bold", size: 26)
	static let alternativeFont = UIFont(name: "Avenir Next Medium", size: 20)
}
struct QuestionInteractionConstants {
	static let delayToPresentOverlayAfterAnswer: Double  = 0.3
	static let delayToRemoveViewControllersFromNavigation: Double = 0.5
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
		removePreviousViewControllersFromNavigation()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		self.navigationController?.viewControllers = [self]
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
	
	// MARK: - Functionality
	func setupUI() {
		setupQuestion()
		setupAlternatives()
	}
	
	func fetchData(currentIndex: Int) -> QuestionViewModel {
		let allQuestions = QuestionsProvider.getQuestions()
		let questionSelected = allQuestions[currentIndex]
		let questionVM = QuestionViewModel(questionObj: questionSelected)
	
		return questionVM
	}
	func removePreviousViewControllersFromNavigation() {
		DispatchQueue.main.asyncAfter(deadline: .now() + QuestionInteractionConstants.delayToRemoveViewControllersFromNavigation) {
			self.navigationController?.viewControllers = [self]
		}
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
		
		let allButtons = getOtherButtonsInStackView(sender: sender)
		
		let correctAnswer = questionViewModel.correctAnswer
		let givenAnswer = sender.titleLabel?.text != nil ? sender.titleLabel!.text! : ""
		
		if givenAnswer == correctAnswer {
			playerGotAnswerRight(on: sender, using: givenAnswer)
		} else {
			playerGotAnswerWrong(on: sender, using: givenAnswer, whenItWas: correctAnswer, from: allButtons)
		}
	
		disableButtons()
		waitForTap()
	}
	func disableButtons() {
		self.stack.isUserInteractionEnabled = false
	}
	func waitForTap() {
		
		presentOverlayWithDelay()
		
	}
	func presentOverlayWithDelay() {
		DispatchQueue.main.asyncAfter(deadline: .now() + QuestionInteractionConstants.delayToPresentOverlayAfterAnswer) {
			self.presentOverlay()
		  }
	}
	
	func presentOverlay() {
		let waitForClickButton = UIButton.init(type: .system)
		waitForClickButton.backgroundColor = .clear //UIColor(named: "AccentColor")
		waitForClickButton.setTitleColor(.label, for: .normal)
		waitForClickButton.titleLabel?.font = TriviaAppUIConstants.alternativeFont
		waitForClickButton.setTitle("Tap anywhere to continue", for: .normal)
		
		// Adding event listener of click to button
		waitForClickButton.addTarget(self, action: #selector(self.waitButtonClicked(_ :)), for: .touchUpInside)
		
		view.addSubview(waitForClickButton)
		
//		waitForClickButton.alpha = 0.3
		
		// Enables auto layout for our button
		waitForClickButton.translatesAutoresizingMaskIntoConstraints = false
		
		waitForClickButton.topAnchor.constraint(equalTo: view.topAnchor, constant: QuestionLayoutConstants.overlayDistanceToViewTop).isActive = true
		waitForClickButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: QuestionLayoutConstants.overlayDistanceToViewBottom).isActive = true
		waitForClickButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: QuestionLayoutConstants.overlayDistanceToViewLeft).isActive = true
		waitForClickButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: QuestionLayoutConstants.overlayDistanceToViewRight).isActive = true
	}
	
	@objc func waitButtonClicked(_ sender: UIButton){
		goToNextQuestion()
	}
	func getOtherButtonsInStackView(sender: UIButton) -> [UIButton] {
		let grandparent = sender.superview?.superview
		let uncles = grandparent?.subviews
		var cousins: [UIButton] = []
		for uncle in uncles! {
			let cousin = uncle.subviews.first as! UIButton
			cousins.append(cousin)
		}
		return cousins
	}
	func playerGotAnswerRight(on sender: UIButton, using givenAnswer: String) {
		changeColor(of: sender, to: .green)
		updateScore()
		print("Congratulations! Your answer was right! \(givenAnswer)")
	}
	func playerGotAnswerWrong(on sender: UIButton, using givenAnswer: String, whenItWas correctAnswer: String, from allButtons: [UIButton]) {
		changeColor(of: sender, to: .red)
		updateScore()
		highlightAnswerCorresponding(to: correctAnswer, from: allButtons)
		print("Sorry, you said \(givenAnswer), but correct answer was \(correctAnswer)")
	}
	func highlightAnswerCorresponding(to correctAnswer: String, from allButtons: [UIButton]) {
		for button in allButtons {
			if button.titleLabel?.text == correctAnswer {
				button.backgroundColor = .yellow
				button.setTitleColor(.black, for: .normal)
			}
		}
	}
	
	func changeColor(of button: UIButton, to color: UIColor) {
		button.backgroundColor = color
		button.setTitleColor(.black, for: .normal)
	}
	func updateScore() {
		
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
			container.addSubview(button)
			
			// Adding event listener of click to button
			button.addTarget(self, action: #selector(buttonClicked(_ :)), for: .touchUpInside)

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
