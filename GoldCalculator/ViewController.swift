//
//  ViewController.swift
//  GoldCalculator
//
//  Created by Miguel Mexicano Herrera on 28/12/23.
//

import UIKit

class ViewController: UIViewController {
    let purityOption = ["14K", "18K", "24K"]
    let pickerView: UIPickerView = UIPickerView()
    @IBOutlet weak var purityTxt: UITextField!
    @IBOutlet weak var goldPriceTxt: UITextField!
    @IBOutlet weak var weightTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
    }
    func setupPickerView() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.purityTxt.inputAccessoryView = toolBar
        self.purityTxt.inputView = pickerView
    }
    @objc func donePicker() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        self.purityTxt.text = self.purityOption[row]
        self.purityTxt.resignFirstResponder()
    }
    @objc func cancelPicker() {
        self.purityTxt.text = nil
        self.purityTxt.resignFirstResponder()
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
        return purityOption[row]
    }
}
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.purityTxt.text = purityOption[row]
    }
}
