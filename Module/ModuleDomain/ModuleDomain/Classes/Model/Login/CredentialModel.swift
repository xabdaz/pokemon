//
//  CredentialModel.swift
//  ModuleDomain_Example
//
//  Created by xabdaz on 07/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
public struct CredentialModel: Codable {
    public let idToken: String
    public let accessToken: String
    public let email: String
    public init(idToken: String, accessToken: String, email: String) {
        self.idToken = idToken
        self.accessToken = accessToken
        self.email = email
    }
}
