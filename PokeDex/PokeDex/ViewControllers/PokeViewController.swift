//
//  PokeViewController.swift
//  PokeDex
//
//  Created by 김도윤 on 2023/01/18.
//

import UIKit
import Kingfisher

class PokeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let apiService = APIService.shared
    private var pokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        apiService.fetchPokemon(startIndex: 0, endIndex: 30) { result in
            self.pokemons = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func collectionViewSetup() {
        collectionView.dataSource = self
        collectionView.collectionViewLayout = TwoColumnFlowLayout()
    }
}

//MARK: CollectionView DataSource
extension PokeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PokemonCollectionViewCell {
            let list = pokemons[indexPath.row]
            cell.nameLabel.text = list.name
            cell.backView.backgroundColor = cell.getColor(type: list.type ?? "")
            cell.imageView.kf.setImage(with: URL(string: list.imageUrl ?? ""))
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
