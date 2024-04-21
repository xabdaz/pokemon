//
//  DomainConvertibleType.swift
//  ModuleCore_Example
//
//  Created by xabdaz on 15/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import QueryKit

protocol DomainConvertibleType {
    associatedtype DomainType

    func asDomain() -> DomainType
}
protocol CoreDataRepresentable {
    associatedtype CoreDataType: Persistable
    
    var uid: String {get}
    
    func update(entity: CoreDataType)
}

extension CoreDataRepresentable {
    func sync(in context: NSManagedObjectContext) -> Observable<CoreDataType> {
        return context.rx.sync(entity: self, update: update)
    }
}

extension Reactive where Base: NSManagedObjectContext {
    func first<T: NSFetchRequestResult>(ofType: T.Type = T.self, with predicate: NSPredicate) -> Observable<T?> {
        return Observable.deferred {
            let entityName = String(describing: T.self)
            let request = NSFetchRequest<T>(entityName: entityName)
            request.predicate = predicate
            do {
                let result = try self.base.fetch(request).first
                return Observable.just(result)
            } catch {
                return Observable.error(error)
            }
        }
    }
    func sync<C: CoreDataRepresentable, P>(entity: C,
                update: @escaping (P) -> Void) -> Observable<P> where C.CoreDataType == P {
        let predicate: NSPredicate = P.primaryAttribute == entity.uid
        return first(ofType: P.self, with: predicate)
            .flatMap { obj -> Observable<P> in
                let object = obj ?? self.base.create()
                update(object)
                return Observable.just(object)
            }
    }
}
extension NSManagedObjectContext {
    func create<T: NSFetchRequestResult>() -> T {
        guard let entity = NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self),
                into: self) as? T else {
            fatalError()
        }
        return entity
    }
}

