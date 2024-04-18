//
//  AppDelegate.swift
//  production
//
//  Created by xabdaz on 07/04/24.
//

import UIKit
import CoreData
import FirebaseCore
import ModuleCore
import ModuleDomain
import Swinject
import SwinjectAutoregistration

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupDependency()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "production")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate {
    func setupDependency() {
        ModuleCoreClass.container.autoregister(PokemonUseCase.self, initializer: PokemonRepositoryUseCase.init)
        
        // MARK: - Coordinator
        ModuleCoreClass.container.autoregister(DetailCoordinator.self, argument: String.self) { dataString in
            ModuleCoreClass.container.register(String.self) { _ in
                return dataString
            }
            return DetailCoordinator(viewModel: ModuleCoreClass.container.resolve(DetailViewModel.self)!)
        }

        // MARK: - viewModel
        ModuleCoreClass.container.autoregister(DetailViewModel.self, initializer: DetailViewModel.init)
    }
}
