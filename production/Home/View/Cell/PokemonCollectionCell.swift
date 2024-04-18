//
//  PokemonCollectionCell.swift
//  production
//
//  Created by xabdaz on 08/04/24.
//

import UIKit
import RxSwift
import Kingfisher
import ModuleCore
import PokemonAPI

class PokemonCollectionCell: UICollectionViewCell {
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var imageViewCustom: UIImageView!
    
    var disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ThemeManager.color.primary
    }

    func setImage(name: String) {
        if
            let imgUrlPokemon = LocalData.getUrlImg(name: name) {
            self.imageViewCustom.kf.setImage(with: URL(string: imgUrlPokemon))
            PokemonAPI().pokemonService.fetchPokemon(name) { res in
                switch res {
                case .success(let success):
                    LocalData.setUrlImg(name: name, url: success.sprites?.frontDefault ?? "")
                case .failure(let failure):
                    break
                }
            }
        } else {
            PokemonAPI().pokemonService.fetchPokemon(name) { res in
                switch res {
                case .success(let success):
                    LocalData.setUrlImg(name: name, url: success.sprites?.frontDefault ?? "")
                case .failure(let failure):
                    break
                }
            }
        }
    }
}
