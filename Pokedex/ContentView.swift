//
//  ContentView.swift
//  Pokedex
//
//  Created by Laura Vega on 11/07/23.
//

import SwiftUI
import URLImage
struct ContentView: View {
    @ObservedObject var pokemonView = PokemonViewModel()
    @State private var isLoading = true
    var body: some View {
        ZStack(alignment: .center){
            Color("redPokedex").ignoresSafeArea()
            VStack {
                ZStack{
                    Text((pokemonView.myPokemon?.name ?? "Pokemon not found").capitalized).font(.custom("Courier", size: 15))
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 15)
                }
                ZStack(alignment: .top){
                            Rectangle().foregroundColor(Color("grayPokedex")).border(.black)
                    VStack{
                        HStack{
                            Circle().frame(width: 7, height: 7, alignment: .trailing).foregroundColor(.red)
                            Circle().frame(width: 7, height: 7, alignment: .trailing).foregroundColor(.red)
                        }.padding(6)
                            
                        ZStack{
                            Rectangle().cornerRadius(10).padding(10).foregroundColor(.white)
                            URLImage(URL(string: pokemonView.image?.imageURL ?? "https://upload.wikimedia.org/wikipedia/commons/5/51/Pokebola-pokeball-png-0.png")!) { image, info in
                                image
                                                      .resizable()
                                                      .aspectRatio(contentMode: .fit).frame(width: 200, height: 200, alignment: .center)
                            }
                        }
                    }
                }.frame(width: 360, height: 290, alignment: .center)
                    .padding(.bottom, 20)
                Button {
                    pokemonView.updatePokemon()
                } label: {
                    Text("Obtener otro pokemon").foregroundColor(.black)
                }.padding(10).background(Color("greenButton")).cornerRadius(10)
                
            }.onAppear{
                pokemonView.fetchPokemon()
            }
            .padding()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
