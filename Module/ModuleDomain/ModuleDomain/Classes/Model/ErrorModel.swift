//
//  ErrorModel.swift
//  ModuleDomain_Example
//
//  Created by xabdaz on 08/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

public struct ErrorModel: Error, Decodable {
    public init(statusCode: Int? = nil, errorCode: String, message: String, verboseMessage: String? = "") {
        self.statusCode = statusCode
        self.errorCode = errorCode
        self.message = message
        self.verboseMessage = verboseMessage
    }
    
    public var statusCode: Int?
    public var errorCode: String
    public var message: String
    public var verboseMessage: String? = ""
    
}
