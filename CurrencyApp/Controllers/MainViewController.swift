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
    
    var currentCharcode = "USD"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        reload()
        setupViews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        setupTableView()
        setupNavbar()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = CGFloat(App.Int.heightMainCell)
        tableView.backgroundColor = UIColor.darkGray
        let cellNib = UINib(nibName: CustomTableViewCell.defaultReuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CustomTableViewCell.defaultReuseIdentifier)
    }
    
    private func setupNavbar() {
        currentCharcodeLabel = UILabel()
        currentCharcodeLabel.textColor = .white
        currentCharcodeLabel.font = UIFont.systemFont(ofSize: 14)
        currentCharcodeLabel.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: currentCharcodeLabel)
    }
    
    @objc
    private func reload() {
        DataManager.getData { currencies in
            DispatchQueue.main.async { [weak self] in
                self?.valutes = currencies
                self?.tableView.reloadData()
                self?.currentCharcodeLabel.text = "USD"
                self?.currentCharcodeLabel.sizeToFit()
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
        
        DataManager.getNewRates(inputCharCode: "\(valute.charCode)", baseCharCode: currentCharcode) { rate, errorStr in
            
            if errorStr != "" {
                // show alert
                
                let alertController = UIAlertController(title: errorStr,
                                                        cancelTitle: "OK")
                
                self.present(alertController, animated: true, completion: nil)
            }
            
            DispatchQueue.main.async {
                cell.valueLabel.text = "\(rate)"
            }
        }
        
        setupFlags(cell: cell, valute: valute)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(App.Int.heightMainCell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valute = valutes[indexPath.row]
        
        valutes.remove(at: indexPath.row)
        valutes.insert(valute, at: valutes.startIndex)
        
        DispatchQueue.main.async { [weak self] in
            self?.currentCharcodeLabel.text = valute.charCode
            self?.currentCharcodeLabel.sizeToFit()
        }
        
        currentCharcode = valute.charCode
        
        _ = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}






























