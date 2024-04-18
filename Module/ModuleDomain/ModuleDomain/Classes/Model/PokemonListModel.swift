//
//  PokemonListModel.swift
//  ModuleDomain_Example
//
//  Created by xabdaz on 07/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import PokemonAPI
public struct PokemonListModel: Codable {
    public let list: [ItemPokemonModel]
    public init(list: [ItemPokemonModel]) {
        self.list = list
    }
}

public struct ItemPokemonModel: Codable {
    public let name: String
    public let url: String
}
public extension PokemonListModel {
    public static func convertFromPokemonPayload(item: [PKMNamedAPIResource<PKMPokemon>]) -> PokemonListModel {
        return PokemonListModel(list: item.map { ItemPokemonModel(name: $0.name ?? "", url: $0.url ?? "")})
    }
}
