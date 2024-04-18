//
//  SplashScreenViewModel.swift
//  production
//
//  Created by xabdaz on 07/04/24.
//

import Foundation
import ModuleCore
import RxSwift
import RxCocoa
import GoogleSignIn
import FirebaseAuth

public class SplashScreenViewModel: BaseViewModel {
    
    let didNavigateToLogin = PublishSubject<Void>()
    let didNavigateToHome = PublishSubject<Void>()
    func setupData() {
        if LocalData.user == nil {
            self.didNavigateToLogin.onNext(())
        } else {
            self.didAuthCredential()
        }
    }
    private func didAuthCredential() {
        guard let user = LocalData.user else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: user.idToken,
                                                       accessToken: user.accessToken)
        Auth.auth().signIn(with: credential) { [weak self] Result, error in
            if error == nil {
                self?.didNavigateToHome.onNext(())
            } else {
                self?.didNavigateToLogin.onNext(())
            }
        }
    }
}
