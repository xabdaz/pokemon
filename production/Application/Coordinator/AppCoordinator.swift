//
//  AppCoordinator.swift
//  production
//
//  Created by xabdaz on 07/04/24.
//

import Foundation
import UIKit
import ModuleCore
import FirebaseCore
import RxSwift


public class AppCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let window: UIWindow
    public init(_ window: UIWindow) {
        self.window = window
    }

    public override func start() {
        self.window.makeKeyAndVisible()
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.navigationBar.barStyle = .black

        FirebaseApp.configure()
        self.navigateToLaunchScreen()
        
    }

    private func navigateToHome() {
        self.removeChildCoordinators()
        let viewModel = HomeViewModel(pokemonUseCase: PokemonRepositoryUseCase())
        let coordinator = HomeCoordinator(viewModel: viewModel)
        self.start(coordinator: coordinator)
        self.setToRoot(coordinator.navigationController)
    }
    
    private func navigateToLaunchScreen() {
        
        self.removeChildCoordinators()
        let viewModel = SplashScreenViewModel()
        let coordinator = SplashScreenCoordinator(viewModel: viewModel)
        self.start(coordinator: coordinator)
        self.setToRoot(coordinator.navigationController)

        viewModel.didNavigateToLogin
            .bind { [weak self] in
                self?.navigateToLogin()
            }.disposed(by: self.disposeBag)

        viewModel.didNavigateToHome
            .bind { [weak self] in
                self?.navigateToHome()
            }.disposed(by: self.disposeBag)
    }

    private func navigateToLogin() {
        self.removeChildCoordinators()
        let viewModel = LoginViewModel()
        let coordinator = LoginCoordinator(viewModel: viewModel)
        self.start(coordinator: coordinator)
        self.setToRoot(coordinator.navigationController)
        
        viewModel.didNavigateToHome
            .bind { [weak self] in
                self?.navigateToHome()
            }.disposed(by: self.disposeBag)
    }
    
    private func setToRoot(_ nav: UINavigationController) {
        ViewControllerUtils.setRootViewController(
            window: self.window,
            viewController: nav,
            withAnimation: true
        )
    }
}
