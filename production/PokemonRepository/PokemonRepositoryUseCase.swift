//
//  PokemonRepositoryUseCase.swift
//  production
//
//  Created by xabdaz on 07/04/24.
//

import Foundation
import ModuleDomain
import RxSwift
import ModuleCore
import PokemonAPI

class PokemonRepositoryUseCase: PokemonUseCase {
    func getList() -> Observable<PokemonListModel> {
        
        if let source = self.params["source"] as? PokemonSource {
            switch source {
            case .server:
                return self.getFromRepository()
            case .cache:
                return self.getFromCache()
            }
        } else {
            return self.getFromRepository()
        }
    }
    private func getFromRepository() -> Observable<PokemonListModel> {
        
        return Observable.create { observer in
            PokemonAPI().pokemonService.fetchPokemonList { result in
                switch result {
                case .success(let success):
                    if let res = success.results as? [PKMNamedAPIResource] {
                        let model = PokemonListModel.convertFromPokemonPayload(item: res)
                        observer.onNext(model)
                        LocalData.lastFetchPokemonData = model
                    }
                case .failure(let failure):
                    observer.onError(failure)
                }
                
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    private func getFromCache() -> Observable<PokemonListModel> {
        if let data = LocalData.lastFetchPokemonData {
            return .just(data)
        } else {
            return self.getFromRepository()
        }
    }
    
    func getDetail() -> Observable<PokemonDetail> {
        guard let name = self.params["name"] as? String else { return .never() }
        return Observable.create { observer in
            PokemonAPI().pokemonService.fetchPokemon(name) { result in
                switch result {
                case .success(let success):
                    var attack: String = ""
                    var hp: String = ""
                    var speed: String = ""
                    var defense: String = ""
                    
                    (success.stats ?? []).forEach { state in
                        if state.stat?.name == "hp" {
                            hp = "\(state.baseStat ?? 0)"
                        }
                        if state.stat?.name == "attack" {
                            attack = "\(state.baseStat ?? 0)"
                        }
                        if state.stat?.name == "defense" {
                            defense = "\(state.baseStat ?? 0)"
                        }
                        if state.stat?.name == "speed" {
                            speed = "\(state.baseStat ?? 0)"
                        }
                    }
                    
                    let model = PokemonDetail(name: success.name ?? "",imageUrl: success.sprites?.frontDefault ?? "", type: success.types?.first?.type?.name ?? "", height: "\(success.height ?? 0) cm", weight: "\(success.weight ?? 0) g", attack: attack, hp: hp, defense: defense, speed: speed)
                    observer.onNext(model)
                case .failure(let failure):
                    observer.onError(failure)
                }

                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    var params: [String : Any] = [:]
    
    
}
