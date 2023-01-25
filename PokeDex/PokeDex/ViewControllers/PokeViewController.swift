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
    var isLoading = false
    var loadingView: LoadingReusableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let loadingReusableNib = UINib(nibName: "LoadingReusableView", bundle: nil)
        collectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "loadingresuableviewid")
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
        collectionView.delegate = self
        collectionView.collectionViewLayout = TwoColumnFlowLayout()
        initListViewRefresh()
    }
}

//MARK: CollectionView DataSource
extension PokeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == pokemons.count-1, !self.isLoading {
            loadMoreData()
        }
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
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                DispatchQueue.main.async {
                    print("load more")
                    self.fetchPokemon(startIndex: self.startIndex, endIndex: self.endIndex+50)
                    self.collectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingresuableviewid", for: indexPath) as! LoadingReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
}
