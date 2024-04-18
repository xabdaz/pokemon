//
//  SplashScreenCoordinator.swift
//  production
//
//  Created by xabdaz on 07/04/24.
//

import Foundation
import ModuleCore

public class SplashScreenCoordinator: BaseCoordinator {
    private let viewModel: SplashScreenViewModel
    public init(viewModel: SplashScreenViewModel) {
        self.viewModel = viewModel
    }
    
    public override func start() {
        let vc = SplashScreenVC(viewModel: self.viewModel)
        self.navigationController.viewControllers = [vc]
    }
    public override func setupBindings() {
    }
}
