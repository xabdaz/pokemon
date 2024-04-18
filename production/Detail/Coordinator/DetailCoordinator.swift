//
//  DetailCoordinator.swift
//  production
//
//  Created by xabdaz on 08/04/24.
//

import Foundation
import ModuleCore
import RxSwift

public class DetailCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let viewModel: DetailViewModel
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }

    public override func start() {
        let vc = DetailVC(viewModel: self.viewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
    public override func setupBindings() {
        self.viewModel.didFinishCoordinator
            .bind(to: self.rx.didFinish)
            .disposed(by: self.disposeBag)
    }
}
