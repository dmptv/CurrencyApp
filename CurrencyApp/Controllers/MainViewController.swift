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
    var currentCharcodeLabel: UILabel!
    
    var valutes: [Valute] = []
    
    var currentValue: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = CGFloat(App.Int.heightMainCell)
        tableView.backgroundColor = UIColor.darkGray
        currentCharcodeLabel = UILabel()
        currentCharcodeLabel.text = "USD"
        currentCharcodeLabel.textColor = .white
        currentCharcodeLabel.font = UIFont.systemFont(ofSize: 14)
        currentCharcodeLabel.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: currentCharcodeLabel)
        
        let cellNib = UINib(nibName: CustomTableViewCell.defaultReuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CustomTableViewCell.defaultReuseIdentifier)

        DataManager.getData { currencies in
            DispatchQueue.main.async { [weak self] in
                
                self?.valutes = currencies
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Helpers

    private func setupFlags(cell: CustomTableViewCell, valute: Valute) {
        
        let charCode = valute.charCode
        if QueryService.charCodeKeys.contains(charCode) {
            if let image = UIImage(named: charCode) {
                cell.countryIcon.image = image.withRenderingMode(.alwaysOriginal)
            } else {
                cell.countryIcon.image = UIImage(named: "unknown")?.withRenderingMode(.alwaysOriginal)
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
        
        setupFlags(cell: cell, valute: valute)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(App.Int.heightMainCell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valute = valutes[indexPath.row]
        
        valutes.remove(at: indexPath.row)
        valutes.insert(valute, at: 0)
        
        DispatchQueue.main.async { [weak self] in
            self?.currentCharcodeLabel.text = valute.charCode
            self?.currentCharcodeLabel.sizeToFit()
        }
        
        _ = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func recalculate() {
        
    }
    
}






























