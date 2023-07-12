//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Laura Vega on 11/07/23.
//

import Foundation

class PokemonViewModel: PokemonDelegate, ImageDelegate, ObservableObject{
  
    var pokemons: [Pokemon]? = nil
    @Published var myPokemon: Pokemon? = nil
    var timer: Timer?
    var pokemonConnector = PokemonConnector()
    var imageConnector = ImageConnector()
    @Published var image: ImageModel? = nil
    
    func didFailtWithError(error: Error) {
        print(error)
    }
    init() {
        pokemonConnector.delegate = self
        imageConnector.delegate = self
        startTimer()
    }
    
    func didUpdateImage(imageModel: ImageModel, pokemon: Pokemon) {
        image = imageModel
        myPokemon = pokemon
    }
    
    func didUpdatePokemon(pokemon: [Pokemon]) {
        pokemons = pokemon;
        getOnePokemon();
    }
    
    func fetchPokemon() {
           pokemonConnector.getPokemon()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
                self.getOnePokemon()
              }
        timer?.fire()
      }
    
    func getOnePokemon(){
       
        if pokemons != nil{
            if let randomValue = pokemons!.randomElement() {
                
                self.imageConnector.getImage(url: randomValue.imageURL, pokemon: randomValue)
                if let index = pokemons!.firstIndex(of: randomValue) {
                    pokemons!.remove(at: index)
                                    }
            }
        }else{
            self.fetchPokemon()
        }
    }
    func updatePokemon(){
        startTimer()
    }
    deinit {
           timer?.invalidate() // Detener el temporizador al destruir el ViewModel
    }
}
