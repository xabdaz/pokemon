//
//  PokemonDetail.swift
//  ModuleDomain_Example
//
//  Created by xabdaz on 07/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
public struct PokemonDetail: Codable {
    public let imageUrl: String
    public let type: String
    public let height: String
    public let weight: String
    public let attack: String
    public let hp: String
    public let defense: String
    public let speed: String
    public let name: String
    public init(name: String, imageUrl: String, type: String, height: String, weight: String, attack: String, hp: String, defense: String, speed: String) {
        self.imageUrl = imageUrl
        self.type = type
        self.height = height
        self.weight = weight
        self.attack = attack
        self.hp = hp
        self.defense = defense
        self.speed = speed
        self.name = name
    }
}
