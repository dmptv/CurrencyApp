//
//  ViewController.swift
//  CurrencyApp
//
//  Created by 123 on 17.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var valutes: [Valute] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = CGFloat(App.Int.heightMainCell)
        tableView.backgroundColor = UIColor.darkGray
        
        let cellNib = UINib(nibName: CustomTableViewCell.defaultReuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CustomTableViewCell.defaultReuseIdentifier)

        DataManager.getData { currencies in
            DispatchQueue.main.async { [weak self] in
                
                self?.valutes = currencies
                self?.tableView.reloadData()
            }
        }
    }


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.defaultReuseIdentifier, for: indexPath) as! CustomTableViewCell
        
        let valute = valutes[indexPath.row]
        
        if indexPath.row == 0 {
            cell.underlineView.backgroundColor = .red
        } else {
            cell.underlineView.backgroundColor = .black
        }
        
        cell.nameLabel.text = valute.name
        cell.charCodeLabel.text = valute.charCode
        cell.valueLabel.text = "\(valute.value)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(App.Int.heightMainCell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valute = valutes[indexPath.row]
        
        valutes.remove(at: indexPath.row)
        valutes.insert(valute, at: 0)
        
        _ = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}





























