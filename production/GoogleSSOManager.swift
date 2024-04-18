//
//  GoogleSSOManager.swift
//  production
//
//  Created by xabdaz on 08/04/24.
//

import Foundation
import RxSwift
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import ModuleDomain

public class GoogleSSOManager: NSObject {
    
    public weak var presentingViewController: UIViewController?
    internal var completion: ((CredentialModel?, Error?) -> Void)?
    public static let shared = GoogleSSOManager()
    public func signIn() -> Single<CredentialModel> {
        return Single.create { [weak self] single in
            guard let `self` = `self` else { return Disposables.create() }
            self.signIn { model, error in
                if let error = error {
                    single(.error(error))
                } else if let model = model {
                    single(.success(model))
                }
            }
            return Disposables.create()
        }
    }
    private func signIn(completion: @escaping (CredentialModel?, Error?) -> Void) {
        self.completion = completion
        guard let clientId = FirebaseApp.app()?.options.clientID else {
            self.completion?(nil, ErrorModel(errorCode: "404", message: "Client Id not Found"))
            return
        }
        
        guard let view = self.presentingViewController else {
            self.completion?(nil, ErrorModel(errorCode: "505", message: "ViewController NotFound"))
            return
        }
        let config = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: view) { [weak self] result, error in
            guard
                let authentication = result?.user,
                let idToken = authentication.idToken?.tokenString
            else {
                self?.completion?(nil, error)
                return
            }
            let email = authentication.fetcherAuthorizer.userEmail
            let model = CredentialModel(idToken: idToken, accessToken: authentication.accessToken.tokenString, email: email ?? "")
            self?.completion?(model, error)
        }
    }
}
