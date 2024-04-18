//
//  HomeCoordinator.swift
//  production
//
//  Created by xabdaz on 08/04/24.
//

import Foundation
import ModuleCore
import RxSwift

public class HomeCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    public override func start() {
        let vc = HomeVC(viewModel: self.viewModel)
        self.navigationController.viewControllers = [vc]
    }

    public override func setupBindings() {
        self.viewModel.didSelectedModel
            .bind { [weak self] item in
                DispatchQueue.main.async {
                    
                    self?.navigateToDetail(name: item.name)
                }
            }.disposed(by: self.disposeBag)
    }
    
    private func navigateToDetail(name: String) {
        let coordinator = ModuleCoreClass.container.resolve(DetailCoordinator.self, argument: name)!
        self.start(coordinator: coordinator)
    }
}
