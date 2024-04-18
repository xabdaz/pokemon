//
//  HomeViewModel.swift
//  production
//
//  Created by xabdaz on 08/04/24.
//

import Foundation
import ModuleDomain
import ModuleCore
import RxSwift
import RxCocoa

public class HomeViewModel: BaseViewModel {

    let outCollection = BehaviorRelay<[ItemPokemonModel]>(value: [])
    let didSelectedModel = PublishSubject<ItemPokemonModel>()
    
    private let disposeBag = DisposeBag()
    private let pokemonUseCase: PokemonUseCase
    public init(pokemonUseCase: PokemonUseCase) {
        self.pokemonUseCase = pokemonUseCase
    }

    func setupData() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let today = formatter.string(from: date)
        
        var source: PokemonSource = .server
        if let lastFetchHourlyCleaningProductDetail = LocalData.lastFetchPokemonList {
            if lastFetchHourlyCleaningProductDetail == today {
                source = .cache
            }
        }
        LocalData.lastFetchPokemonList = today
        self.pokemonUseCase.params["source"] = source
        self.pokemonUseCase.getList()
            .subscribe { [weak self] response in
                self?.outCollection.accept(response.list)
            } onError: { [weak self] error in
                self?.handelError(error)
            } onCompleted: {
            } onDisposed: {
            }.disposed(by: self.disposeBag)

    }

}
