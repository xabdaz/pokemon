//
//  DetailViewModel.swift
//  production
//
//  Created by xabdaz on 08/04/24.
//

import Foundation
import ModuleCore
import ModuleDomain
import RxSwift
public class DetailViewModel: BaseViewModel {
    let didData = PublishSubject<PokemonDetail>()

    private let disposeBag = DisposeBag()
    private let useCase: PokemonUseCase
    private let name: String
    init(useCase: PokemonUseCase, name: String) {
        self.useCase = useCase
        self.name = name
    }

    func setupData() {
        self.useCase.params["name"] = self.name
        self.useCase.getDetail()
            .subscribe { [weak self] detail in
                self?.didData.onNext(detail)
            } onError: { error in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)

    }
}
