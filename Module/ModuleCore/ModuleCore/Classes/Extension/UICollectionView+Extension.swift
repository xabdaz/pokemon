//
//  UICollectionView+Extension.swift
//  ModuleCore_Example
//
//  Created by xabdaz on 08/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
public extension UICollectionView {
    
    @discardableResult
    func registerReusable(withClass cellClass: Reusable.Type, fromNib: Bool = false) -> UICollectionView {
        if fromNib {
            let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil)
            register(nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }
        
        return self
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass cellClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: Reusable { }
