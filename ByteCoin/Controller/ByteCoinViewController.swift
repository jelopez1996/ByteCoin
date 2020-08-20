//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ByteCoinViewController: UIViewController {

    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var countryPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        coinManager.delegate = self
        coinManager.fetchPrice(country: currencyLabel.text!)
        super.viewDidLoad()
    }


}

//MARK: - CoinManager Delegate

extension ByteCoinViewController: CoinManagerDelegate {
    
    func didUpdateRate(_ coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.bitCoinLabel.text = coinModel.formatedRate
            self.currencyLabel.text = coinModel.country
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    
    
}

//MARK: - UIPicker Data Source

extension ByteCoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}
//MARK: - UI Picker Delegate

extension ByteCoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let country = coinManager.currencyArray[row]
        coinManager.fetchPrice(country: country)
        
    }
}

