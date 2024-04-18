//
//  SceneDelegate.swift
//  production
//
//  Created by xabdaz on 07/04/24.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private let disposeBag = DisposeBag()
    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator!
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        self.appCoordinator = AppCoordinator(self.window!)
        self.appCoordinator.start()
        self.appCoordinator.setupBindings()
    }
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
    }
    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

