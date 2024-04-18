//
//  LocalData.swift
//  ModuleCore_Example
//
//  Created by xabdaz on 07/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import ModuleDomain

public class LocalData {
    static let shared = LocalData()

    var staticUser: CredentialModel? = nil
    var staticDataPokemon: PokemonListModel? = nil
    public static var user: CredentialModel? {
        set {
            shared.staticUser = newValue
            if newValue == nil {
                Functions.setToPlist("user", object: nil as Data?)
            } else {
                let encoder = JSONEncoder()
                 let dateFormatter = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss.S")
                encoder.dateEncodingStrategy = .formatted(dateFormatter)
                let encodedData = try? encoder.encode(newValue)
                Functions.setToPlist("user", object: encodedData)
            }
        }
        get { 
            if shared.staticUser == nil {
                if let jsonData: Data = Functions.getFromPlist("user") {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss.S")
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    let user = try? decoder.decode(CredentialModel.self, from: jsonData)
                    shared.staticUser = user
                }
            }
            return shared.staticUser
        }
    }
    
    public static var lastFetchPokemonList: String? {
        set {
            Functions.setToPlist("lastFetchPokemonList", object: newValue)
        }
        get {
            return Functions.getFromPlist("lastFetchPokemonList")
        }
    }
    public static var lastFetchPokemonData: PokemonListModel? {
        set {
            shared.staticDataPokemon = newValue
            if newValue == nil {
                Functions.setToPlist("lastFetchPokemonData", object: nil as Data?)
            } else {
                let encoder = JSONEncoder()
                 let dateFormatter = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss.S")
                encoder.dateEncodingStrategy = .formatted(dateFormatter)
                let encodedData = try? encoder.encode(newValue)
                Functions.setToPlist("lastFetchPokemonData", object: encodedData)
            }
        }
        get {
            if shared.staticDataPokemon == nil {
                if let jsonData: Data = Functions.getFromPlist("lastFetchPokemonData") {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss.S")
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    let user = try? decoder.decode(PokemonListModel.self, from: jsonData)
                    shared.staticDataPokemon = user
                }
            }
            return shared.staticDataPokemon
        }
    }
    public static func getUrlImg(name: String) -> String? {
        return Functions.getFromPlist(name)
    }
    
    public static func setUrlImg(name: String, url: String) {
        Functions.setToPlist(name, object: url)
    }
}
extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
