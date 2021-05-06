//
//  QuestionsProvider.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 05/05/2021.
//

import Foundation

class QuestionsProvider {
	
	enum ResponseType {
		case success
		case failure
		
		var fileName: String {
			switch self {
			case .success:
				return "success_response"
			case .failure:
				return "failure_response"
			}
		}
	}
	
	static func getQuestions() -> [Question] {
		guard let data = readLocalFile(with: .success) else { return [] }
		let (_, questions) = parse(jsonData: data)
		
		return questions
	}
	
	private static func readLocalFile(with responseType: ResponseType) -> Data? {
		do {
			if let bundlePath = Bundle.main.path(forResource: responseType.fileName,
												 ofType: "json"),
				let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
				return jsonData
			}
		} catch {
			print(error)
		}
		
		return nil
	}
	private static func parse(jsonData: Data) -> (Int, [Question]) {
		
		do {
			let decodedData = try JSONDecoder().decode(Response.self,
													   from: jsonData)
			
			print("ResponseCode: ", decodedData.responseCode)
			print("Count of results: ", decodedData.results.count)
			print("===================================")
			return (0, decodedData.results)
		} catch {
			print("decode error")
		}
		return (1, [])
	}
}
