//
//  BaseViewController.swift
//  ModuleCore_Example
//
//  Created by xabdaz on 07/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

open class BaseViewController: UIViewController {
    public init() {
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }

    public init(withIdentifer: String) {
        let bundlerUrl = Bundle.main.url(forResource: withIdentifer, withExtension: "bundle")
        let bundle = Bundle(url: bundlerUrl!)
        super.init(nibName: String(describing: Self.self), bundle: bundle)
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(
            nibName: nibNameOrNil ?? String(describing: Self.self),
            bundle: nibBundleOrNil ?? Bundle(for: Self.self)
        )
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.setupGestureBack()
    }

    open func setupGestureBack() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    open var identifer: String {
        return String(describing: Self.self)
    }
    deinit {
        onFinishCoordinator()
    }
}

@objc extension BaseViewController {
    open func onFinishCoordinator() {
        
    }
}
public extension Reactive where Base: BaseViewController {

}
extension BaseViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
