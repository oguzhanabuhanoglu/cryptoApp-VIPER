//
//  view.swift
//  VIPER
//
//  Created by Oğuzhan Abuhanoğlu on 6.11.2023.
//

import Foundation
import UIKit

// class, protocol
// talks -> to presenter
// viewcontroller



protocol AnyView {
    
    var presenter : AnyPresenter? {get set}
    
    func update(with cryptos : [Crypto])
    func update(with Error : String)
    
}


class CryptoViewController : UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    
    var presenter : AnyPresenter?
    
    var cryptos : [Crypto] = []
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading.."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let widht = view.frame.size.width
        let height = view.frame.size.height
        
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: widht * 0.5 - 100, y: height * 0.5 - 25, width: 200, height: 50)
        
    }
    
    func update(with Error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messageLabel.text = Error
            self.messageLabel.isHidden = false
        }
        
    }
    
    
    func update(with cryptos: [Crypto]) {
        
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        return cell
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = detailsVC()
        secondViewController.currency = cryptos[indexPath.row].currency
        secondViewController.price = cryptos[indexPath.row].price
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    
    
}



//aynı viperin içine ikinci viewi eklemek

class detailsVC : UIViewController {
    
    var currency : String = ""
    var price : String = ""
    
    private let currencyLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        view.addSubview(currencyLabel)
        view.addSubview(priceLabel)
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let widht = view.frame.size.width
        let height = view.frame.size.height
        
        currencyLabel.frame = CGRect(x: widht * 0.5 - 100, y: height * 0.5 - 25, width: 200, height: 50)
        priceLabel.frame = CGRect(x: widht * 0.5 - 100, y: height * 0.65 - 25, width: 200, height: 50)
        
        currencyLabel.text = currency
        priceLabel.text = price
    }
    
    
    
    
    
}
