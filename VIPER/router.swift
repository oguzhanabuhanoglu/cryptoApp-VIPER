//
//  router.swift
//  VIPER
//
//  Created by Oğuzhan Abuhanoğlu on 6.11.2023.
//

import Foundation
import UIKit


//class, protocol
//entrypoint - mainviewi sildiğimiz için oluşturmamiz gereken first view denebilir.ama burda oluşturmamız yetmeyecek bunu gidip scene delgate altında ki fonksiyonlarda göstememiz gerekecek.(root view controller)

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    
    var entry : EntryPoint? {get}
    
    static func startExecution() -> AnyRouter
    
}

//Routerın görevi çalışacağım diğer sınıfları viewları orkestra etkem yönetmek, dolasıyla presenter, interactor vs ögelerini tanımlayıp routerın altında işler hale getirip entitypoint oluşturacağız.

class CryptoRouter : AnyRouter {
    
    var entry: EntryPoint?
    
    // bu fonksiyon bir anyrouter dondurulmesini istiyor.
    // her şeyi birbirine bağlayıp çalıştıracağımız fonksiyon
    static func startExecution() -> AnyRouter {
        
        
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint

        
        return router
    }
}

