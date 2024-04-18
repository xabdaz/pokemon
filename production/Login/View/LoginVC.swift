//
//  LoginVC.swift
//  production
//
//  Created by xabdaz on 07/04/24.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth
import RxSwift
import ModuleCore
import ModuleDomain

class LoginVC: BaseViewController {
    let didNavigateToHome = PublishSubject<Void>()
    private let viewModel: LoginViewModel
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        GoogleSSOManager.shared.presentingViewController = self
        self.view.backgroundColor = ThemeManager.color.primary
    }

    @IBAction func functionLogin(_ sender: UIButton) {
        self.viewModel.didLogin()
    }
}
