//
//  ViewController.swift
//  ByteCoin
//
//  Created by Александр on 24.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
    }

}

//MARK: - UIPickerView
extension ViewController: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currancyChosen = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currancyChosen)
    }
}

//MARK: - CoinManager delegate
extension ViewController: CoinManagerDelegate {
    
    func didUpdateData(_ delegate: CoinManager, with data: CoinData) {
        DispatchQueue.main.sync {
            bitcoinLabel.text = String(data.rate)
            currencyLabel.text = data.asset_id_quote
        }
    }
    
    func didFailWithError(_ delegate: CoinManager, error: Error) {
        print(error)
    }
}

