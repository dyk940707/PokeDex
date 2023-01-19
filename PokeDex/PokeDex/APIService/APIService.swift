//
//  APIService.swift
//  PokeDex
//
//  Created by 김도윤 on 2023/01/18.
//

import Foundation
import PokemonAPI

struct APIService {
    static let shared = APIService()
    
    func fetchPokemon(startIndex: Int, endIndex: Int, completion: @escaping([Pokemon]) -> ()) {
        var pokemons = [Pokemon]()
        for id in startIndex...endIndex {
            PokemonAPI().pokemonService.fetchPokemon(id) { result in
                switch result {
                case .success(let pokemon):
                    let po = Pokemon(id: pokemon.id,
                            name: pokemon.name,
                            imageUrl: pokemon.sprites?.frontDefault,
                            backImageUrl: pokemon.sprites?.backDefault,
                            weight: pokemon.weight,
                            height: pokemon.height,
                            baseExperience: pokemon.baseExperience)
                    pokemons.append(po)
                    completion(pokemons)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
