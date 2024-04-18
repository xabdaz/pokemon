//
//  PokemonUseCase.swift
//  ModuleDomain_Example
//
//  Created by xabdaz on 07/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
public protocol PokemonUseCase: AnyObject {
    func getList() -> Observable<PokemonListModel>
    func getDetail() -> Observable<PokemonDetail>
    var params: [String: Any] { get set }
}
