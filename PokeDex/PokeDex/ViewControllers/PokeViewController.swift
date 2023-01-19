//
//  PokeViewController.swift
//  PokeDex
//
//  Created by 김도윤 on 2023/01/18.
//

import UIKit

class PokeViewController: UIViewController {

    var poke = [Pokemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService().fetchPokemon(startIndex: 0, endIndex: 30) { result in
            self.poke = result
        }
    }
    
}
