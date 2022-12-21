//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

//UIPickerViewDataSource is a protocol that can provide data to any UIPickerViews
class CoinViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set the viewcontroller class as the datasource to the currencyPicker object
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
}

//MARK: - UIPickerView Delegate & DataSource
extension CoinViewController:  UIPickerViewDataSource, UIPickerViewDelegate {
    
    //Number of column to display in the UIViewPicker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Return the number of ligne to display in the UIViewPicker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    //the Delegate method for the class uipickerviewwDelegate
    //Return the content to display in the UIViewPicker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    //row is the index of the current label in the table
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrentText = coinManager.currencyArray[row]
        coinManager.fetchData(selectedCurrentText)
    }
}

//MARK: - CoinManagerDelegate

extension CoinViewController: CoinManagerDelegate{
    
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.rateString
            self.currencyLabel.text = coin.name
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
