//
//  PokemonConnector.swift
//  Pokedex
//
//  Created by Laura Vega on 11/07/23.
//

import Foundation
protocol PokemonDelegate{
    func didUpdatePokemon(pokemon: [Pokemon])
    func didFailtWithError(error: Error)
}

struct PokemonConnector{
    var delegate: PokemonDelegate?
    let pokemonUrl: String = "https://pokeapi.co/api/v2/pokemon?limit=1281"
    func getPokemon(){
        pokeFetch(urlString: pokemonUrl)
    }
  
    func pokeFetch(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){data, response, error in
                if error != nil {
                    self.delegate?.didFailtWithError(error: error!)
                }
                if let dataResponse = data {
                    if let pokemon = self.convertJSON(pokemonData : dataResponse){
                        self.delegate?.didUpdatePokemon(pokemon: pokemon)
                    }
                }
                
            }
            task.resume()
        }
    }
    func convertJSON(pokemonData: Data) -> [Pokemon]? {
        let decoder = JSONDecoder()
        do{
            let decodePokemon = try decoder.decode(Pokeapi.self, from: pokemonData)
            let pokemonResult = decodePokemon.results?.compactMap({
                if let name = $0.name, let imageURL = $0.url{
                    return Pokemon(name: name, imageURL: imageURL)
                }
                return nil;
            })
            return pokemonResult;
        }catch{
            return nil;
        }
    }
}
extension Collection where Indices.Iterator.Element == Index{
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}
extension Collection {
    func choose(_ n: Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}
