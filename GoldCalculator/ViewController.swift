//
//  ViewController.swift
//  GoldCalculator
//
//  Created by Miguel Mexicano Herrera on 28/12/23.
//

import UIKit
import NutUtils
class ViewController: UIViewController {
    let purityOption = [10.0, 14.0, 18.0, 24.0]
    let pickerView: UIPickerView = UIPickerView()
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var purityTxt: UITextField!
    @IBOutlet weak var goldPriceTxt: UITextField!
    @IBOutlet weak var weightTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupPrice()
    }
    func setupPickerView() {
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))
        let toolBar = toolBar(actions: [cancelButton, spaceButton, doneButton])
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.purityTxt.inputAccessoryView = toolBar
        self.purityTxt.inputView = pickerView
        self.goldPriceTxt.delegate = self
        self.goldPriceTxt.inputAccessoryView = toolBar
    }
    func toolBar(actions: [UIBarButtonItem]) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        toolBar.setItems(actions, animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    func setupPrice() {
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneTextField))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelTextField))
        let toolBar = toolBar(actions: [cancelButton, spaceButton, doneButton])
        self.goldPriceTxt.delegate = self
        self.goldPriceTxt.inputAccessoryView = toolBar
        self.weightTxt.delegate = self
        self.weightTxt.inputAccessoryView = toolBar
    }
    @objc func donePicker() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        self.purityTxt.text = "\(self.purityOption[row]) K"
        self.purityTxt.resignFirstResponder()
    }
    @objc func cancelPicker() {
        self.purityTxt.text = nil
        self.purityTxt.resignFirstResponder()
    }
    @objc func doneTextField() {
        self.goldPriceTxt.resignFirstResponder()
        self.weightTxt.resignFirstResponder()
    }
    @objc func cancelTextField() {
        self.goldPriceTxt.resignFirstResponder()
        self.weightTxt.resignFirstResponder()
    }
    @IBAction func processPrice(_ sender: Any) {
        if let price = goldPriceTxt.text, !price.isEmpty, let purity = purityTxt.text, !purity.isEmpty, let weight = weightTxt.text, !weight.isEmpty {
            if let priceDouble = Double(price), let weightDouble = Double(weight) {
                let basePurity = 24.0
                let row = self.pickerView.selectedRow(inComponent: 0)
                let purityDouble = self.purityOption[row]
                let result = (purityDouble/basePurity) * weightDouble * priceDouble
                resultLabel.text = result.currency
            } else {
                showAlert(title: "Error", message: "Formato Incorrecto")
            }
        } else {
            showAlert(title: "Error", message: "Los campos son obligatorios")
        }
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let done = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(done)
        self.present(alert, animated: true)
    }
}
extension ViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return purityOption.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.purityOption[row]) K"
    }
}
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.purityTxt.text = "\(self.purityOption[row]) K"
    }
}
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "")
    }
}
