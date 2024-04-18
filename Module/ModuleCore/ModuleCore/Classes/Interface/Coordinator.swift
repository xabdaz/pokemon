//
//  Coordinator.swift
//  ModuleCore_Example
//
//  Created by xabdaz on 07/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }

    func start()
    func setupBinding()
    
    func start(_ coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func removeChildCoordinators()
    func didCloseView(
        animated: Bool,
        resultCode: Int,
        resultData: Any?,
        _ completion: (() -> Void)?
    )
    var onRelease: ((_ resultCode: Int, _ data: Any?) -> Void)? { get set }
    func didReleaseCoordinator(_ resultCode: Int, _ data: Any?)
}
