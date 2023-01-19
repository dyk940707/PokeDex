//
//  PokemonCollectionViewCell.swift
//  PokeDex
//
//  Created by 김도윤 on 2023/01/19.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 20
    }
    
    func getColor(type: String) -> UIColor {
        switch type {
        case "fire": return .systemRed
        case "poison": return .systemGreen
        case "water": return .systemBlue
        case "electric": return .systemYellow
        case "physic": return .systemPurple
        case "normal": return .systemOrange
        case "ground": return .systemGray
        case "flying": return .systemTeal
        case "bug": return .systemTeal
        case "fairy": return .systemPink
        case "grass": return .systemGreen
        default: return .systemIndigo
        }
    }
}
