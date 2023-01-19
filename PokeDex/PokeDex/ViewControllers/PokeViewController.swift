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
    
    private var startIndex = 1
    private var endIndex = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        fetchPokemon(startIndex: startIndex, endIndex: endIndex)
    }
    
    //MARK: 리스트 스크롤 새로고침
    private func initListViewRefresh() {
        let refresh = UIRefreshControl()
        refresh.tintColor = .black
        refresh.addTarget(self, action: #selector(listRefresh(refresh: )), for: .valueChanged)
        collectionView.refreshControl = refresh
    }
    

    //MARK: 새로고침이 끝났을때
    @objc func listRefresh(refresh: UIRefreshControl) {
        fetchPokemon(startIndex: startIndex, endIndex: endIndex)
        refresh.endRefreshing()
    }
    
    private func fetchPokemon(startIndex: Int, endIndex: Int) {
        apiService.fetchPokemon(startIndex: startIndex, endIndex: endIndex) { result in
            self.pokemons = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func collectionViewSetup() {
        collectionView.dataSource = self
        collectionView.collectionViewLayout = TwoColumnFlowLayout()
        initListViewRefresh()
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
