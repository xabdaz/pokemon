//
//  DetailVC.swift
//  production
//
//  Created by xabdaz on 08/04/24.
//

import UIKit
import ModuleCore
import RxSwift

class DetailVC: BaseViewController {
    
    
    @IBOutlet weak var attackContainer: UIView!
    @IBOutlet weak var hpContainer: UIView!
    @IBOutlet weak var defenseContainer: UIView!
    @IBOutlet weak var speedContainer: UIView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var containerPokemopn: UIView!
    @IBOutlet weak var heightPokemon: UILabel!
    @IBOutlet weak var weightPokemon: UILabel!
    @IBOutlet weak var typePokemon: UILabel!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var titleBarLabel: UILabel!
    private let disposeBag = DisposeBag()
    private let viewModel: DetailViewModel
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerPokemopn.backgroundColor = ThemeManager.color.primary
        self.containerPokemopn.layer.cornerRadius = 15
        self.attackContainer.backgroundColor = ThemeManager.color.primary
        self.attackContainer.layer.cornerRadius = 5
        self.hpContainer.backgroundColor = ThemeManager.color.primary
        self.hpContainer.layer.cornerRadius = 5
        self.defenseContainer.backgroundColor = ThemeManager.color.primary
        self.defenseContainer.layer.cornerRadius = 5
        self.speedContainer.backgroundColor = ThemeManager.color.primary
        self.speedContainer.layer.cornerRadius = 5

        self.viewModel.didData
            .subscribe { [weak self] data in
                let item = data.element
                DispatchQueue.main.async {
                    self?.titleBarLabel.text = item?.name
                    self?.imgPokemon.kf.setImage(with: URL(string: item?.imageUrl ?? ""))
                    self?.namePokemon.text = item?.name
                    self?.typePokemon.text = "Type: \(item?.type ?? "")"
                    self?.weightPokemon.text = "Wight: \(item?.weight ?? "")"
                    self?.heightPokemon.text = "Height: \(item?.height ?? "")"
                    self?.attackLabel.text = item?.attack
                    self?.hpLabel.text = item?.hp
                    self?.defenseLabel.text = item?.defense
                    self?.speedLabel.text = item?.speed
                }
            }.disposed(by: self.disposeBag)
        self.viewModel.setupData()
    }

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func onFinishCoordinator() {
        self.viewModel.didFinishCoordinator.onNext(())
    }
}
