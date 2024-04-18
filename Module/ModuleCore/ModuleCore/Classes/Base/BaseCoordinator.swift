//
//  BaseCoordinator.swift
//  ModuleCore_Example
//
//  Created by xabdaz on 07/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

open class BaseCoordinator: NSObject, Coordinator {
    public var navigationController = UINavigationController()
    public var childCoordinators = [Coordinator]()
    public var parentCoordinator: Coordinator?
    
    public var onRelease: ((_ resultCode: Int, _ data: Any?) -> Void)?
    public var resultCode: Int = CoordinatorResult.NONE
    public var resultData: Any?

    public override init() {
        super.init()
    }
    
    open func start() {
        fatalError("Start method should be implemented.")
    }

    public func setupBinding() {
        self.setupBindings()
    }

    open func start(_ coordinator: Coordinator) {
        self.childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.navigationController = self.getNavigationController()
        coordinator.setupBinding()
        coordinator.onRelease = self.didReleaseCoordinator
        coordinator.start()
    }

    open func start(coordinator: Coordinator, _ forceAddCoordinator: Bool = false) {
        if forceAddCoordinator {
            self.start(coordinator)
        } else {
            if self.childCoordinators.count == 0 {
                self.start(coordinator)
            }
        }
    }

    public func didReleaseCoordinator(_ resultCode: Int, _ data: Any?) {
        self.didRelease(resultCode: resultCode, data: data)
    }
 
    open func removeChildCoordinators() {
        self.childCoordinators.forEach { $0.removeChildCoordinators() }
        self.childCoordinators.removeAll()
    }

    open func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }

    open func getNavigationController() -> UINavigationController {
        guard let navigation = navigationController.presentedViewController as? UINavigationController else {
            return self.navigationController
        }
        return navigation
    }
    
    open func didCloseView(
        animated: Bool = true,
        resultCode: Int = CoordinatorResult.NONE,
        resultData: Any? = nil,
        _ completion: (() -> Void)? = nil
    ) {
        self.resultCode = resultCode
        self.resultData = resultData
    }

    deinit {
        onRelease?(resultCode, resultData)
    }
}
public typealias CoordinatorResult = Int
public extension CoordinatorResult {
    static let NONE = 0
    static let DATA = 1
}
@objc extension BaseCoordinator {
    open func setupBindings() {
        
    }
    open func didRelease(resultCode: Int, data: Any?) {
    }
}

public extension Reactive where Base: BaseCoordinator {
    var didFinish: Binder<Void> {
        return Binder(self.base) { coordinator, _ in
            coordinator.parentCoordinator?.didFinish(coordinator: coordinator)
        }
    }
}
