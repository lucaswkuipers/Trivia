//
//  SceneDelegate.swift
//  Trivia
//
//  Created by Lucas Werner Kuipers on 01/05/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		// Window
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)
		
		// Controller and Navigation
		let mainMenuVC = MainMenuVC()
		let navigationController = UINavigationController(rootViewController: mainMenuVC)
		navigationController.isNavigationBarHidden = true
		
		// Connecting window to controllers
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
		self.window = window
	}
	func sceneDidDisconnect(_ scene: UIScene) {
	}
	func sceneDidBecomeActive(_ scene: UIScene) {
	}
	func sceneWillResignActive(_ scene: UIScene) {
	}
	func sceneWillEnterForeground(_ scene: UIScene) {
	}
	func sceneDidEnterBackground(_ scene: UIScene) {
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
}

