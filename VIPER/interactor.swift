//
//  interactor.swift
//  VIPER
//
//  Created by Oğuzhan Abuhanoğlu on 6.11.2023.
//

import Foundation

//MVVM de ki modelview yapısı gibidir.ana işlemler data alma vs burada döner
//talks to -> presenter

protocol AnyInteractor {
    
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
    
}

class CryptoInteractor : AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                self.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.networkFailed))
                return
            }
            
            do{
                //burada datayi webden aldık ve presentera pasladık.
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            } catch {
                self.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.parsingFailed))
                
            }

        }
        
        task.resume()
        
    }
    
    
}
