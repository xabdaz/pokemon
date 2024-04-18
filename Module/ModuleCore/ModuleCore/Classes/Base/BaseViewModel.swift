//
//  BaseViewModel.swift
//  ModuleCore_Example
//
//  Created by xabdaz on 07/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift

open class BaseViewModel: NSObject {
    public let didFinishCoordinator = PublishSubject<Void>()
    public override init() {
        super.init()
        self.setupBindings()
    }

    open func handelError(_ error: Error) {
    }
}
@objc extension BaseViewModel {
    open func setupBindings() {
        
    }
}
