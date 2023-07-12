//
//  ImageConnect.swift
//  Pokedex
//
//  Created by Laura Vega on 12/07/23.
//

import Foundation
protocol ImageDelegate{
    func didUpdateImage(imageModel: ImageModel, pokemon: Pokemon)
    func didFailtWithError(error: Error)
}

struct ImageConnector{
    var delegate: ImageDelegate?
    
    func getImage(url: String, pokemon: Pokemon){
        imageFetch(urlString: url, pokemon: pokemon)
    }
  
    func imageFetch(urlString: String, pokemon: Pokemon){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){data, response, error in
                if error != nil {
                    self.delegate?.didFailtWithError(error: error!)
                }
                if let dataResponse = data {
                    if let image = self.convertJSON(imageData : dataResponse){
                        self.delegate?.didUpdateImage(imageModel: image, pokemon: pokemon)
                    }
                }
                
            }
            task.resume()
        }
    }
    func convertJSON(imageData: Data) -> ImageModel? {
        let decoder = JSONDecoder()
        do{
            let decodeImage = try decoder.decode(ImageData.self, from: imageData)
            let image = decodeImage.sprites.other?.officialArtwork.frontDefault ?? ""
                return ImageModel(imageURL: image)
            
          
        }catch{
            return nil;
        }
    }
}
