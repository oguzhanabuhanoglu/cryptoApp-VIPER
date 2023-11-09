//
//  presenter.swift
//  VIPER
//
//  Created by Oğuzhan Abuhanoğlu on 6.11.2023.
//

import Foundation

//class, protocol
// talks to -> interactor, router, view

enum NetworkError : Error {
    case networkFailed
    case parsingFailed
}

protocol AnyPresenter {
    
    var view : AnyView? {get set}
    var interactor : AnyInteractor? {get set}
    var router : AnyRouter? {get set}
    
    
    func interactorDidDownloadCrypto(result: Result<[Crypto],Error>)
    
}


class CryptoPresenter : AnyPresenter {
    
    var view: AnyView?
    
    var interactor: AnyInteractor?{
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var router: AnyRouter?
    
//    crypto indirilmiş ve gelmiş olcak.viewdaki güncellmeleri buradan yapacağız.
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case.success(let cryptos):
            //view update
            view?.update(with: cryptos)
        case.failure(_):
            // view error
            view?.update(with: "try again")
        }
    }
    
    
    
}
