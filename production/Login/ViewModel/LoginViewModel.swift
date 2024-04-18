//
//  LoginViewModel.swift
//  production
//
//  Created by xabdaz on 08/04/24.
//

import Foundation
import ModuleCore
import RxSwift
import RxCocoa

public class LoginViewModel: BaseViewModel {
    let didNavigateToHome = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    func didLogin() {
        GoogleSSOManager.shared.signIn()
            .subscribe { [weak self] model in
                LocalData.user = model
                self?.didNavigateToHome.onNext(())
            } onError: { error in
            }.disposed(by: self.disposeBag)

    }
}
