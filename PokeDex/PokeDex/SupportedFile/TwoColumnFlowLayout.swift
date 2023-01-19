//
//  TwoColumnFlowLayout.swift
//  PokeDex
//
//  Created by 김도윤 on 2023/01/19.
//
import UIKit

class TwoColumnFlowLayout: UICollectionViewFlowLayout {

    //MARK: - Init
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Setup
    
    func setupLayout() {
        minimumLineSpacing = 1.0
        minimumInteritemSpacing = 1.0
        scrollDirection = .vertical
    }
    
    //MARK: - Item size
    
    override var itemSize: CGSize {
        set { }
        get {
            let numberOfColumns: CGFloat = 2.0
            let halfWidth: CGFloat = (self.collectionView?.frame.width ?? 0.0) / numberOfColumns
            let space: CGFloat = 1.0
            let itemWidth = halfWidth - space
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
}
