//
//  HomeVC.swift
//  production
//
//  Created by xabdaz on 07/04/24.
//

import UIKit
import PokemonAPI
import CoreData
import ModuleCore
import ModuleDomain
import RxSwift

class HomeVC: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerReusable(withClass: PokemonCollectionCell.self, fromNib: true)
        
        
        let layoutCollection: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layoutCollection.minimumLineSpacing = 15
        
        layoutCollection.scrollDirection = .vertical
        layoutCollection.itemSize = CGSize(width: ((UIScreen.main.bounds.width - 30) / CGFloat(2)) - 15, height: ((UIScreen.main.bounds.width) / CGFloat(2)))
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.setCollectionViewLayout(layoutCollection, animated: true)
        
        self.viewModel.outCollection
            .bind(to: self.collectionView.rx.items(
                cellIdentifier: PokemonCollectionCell.reuseIdentifier, cellType: PokemonCollectionCell.self
            )) { _, item, cell in
                cell.disposeBag = DisposeBag()
                cell.imageViewCustom.image = UIImage(named: "ic_pokemon")
                cell.layer.cornerRadius = 15
                cell.pokemonNameLabel.text = item.name
                cell.setImage(name: item.name)
            }.disposed(by: self.disposeBag)
        

        self.collectionView.rx.modelSelected(ItemPokemonModel.self)
            .bind(to: self.viewModel.didSelectedModel)
            .disposed(by: self.disposeBag)

        self.viewModel.setupData()
    }

}
