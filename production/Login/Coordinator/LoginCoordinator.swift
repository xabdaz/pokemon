//
//  LoginCoordinator.swift
//  production
//
//  Created by xabdaz on 08/04/24.
//

import Foundation
import ModuleCore

public class LoginCoordinator: BaseCoordinator {
    private let viewModel: LoginViewModel
    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    public override func start() {
        let vc = LoginVC(viewModel: self.viewModel)
        self.navigationController.viewControllers = [vc]
    }
}
