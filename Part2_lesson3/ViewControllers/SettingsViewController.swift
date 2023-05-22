//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Даниил Чупин on 04.05.2023.
//  Modified by Даниил Чупин on 22.05.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - IB outlets
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redNumber: UILabel!
    @IBOutlet weak var greenNumber: UILabel!
    @IBOutlet weak var blueNumber: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var doneButton: UIBarButtonItem!
    var bgColor: UIColor!
    unowned var delegate: ColorSelectionDelegate!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        setupFromMain()
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        setupToolbar()
    }
    
    @objc func doneButtonTapped() {
        redTextField.resignFirstResponder()
        greenTextField.resignFirstResponder()
        blueTextField.resignFirstResponder()
    }
    
    // MARK: - IB actions
    @IBAction func rgbSlider(_ sender:UISlider) {
        setColor()
        
        switch sender {
        case redSlider:
            redNumber.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenNumber.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueNumber.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    // MARK: - Private methods
    private func setColor() {
        let selectedColor = UIColor(red: CGFloat(redSlider.value),
                                   green: CGFloat(greenSlider.value),
                                   blue: CGFloat(blueSlider.value),
                                   alpha: 1.00)
        colorView.backgroundColor = selectedColor
        delegate.didSelectColor(selectedColor)
    }
    
    private func setupFromMain() {
        colorView.backgroundColor = bgColor
        
        redSlider.value = Float(bgColor.cgColor.components?[0] ?? 0)
        greenSlider.value = Float(bgColor.cgColor.components?[1] ?? 0)
        blueSlider.value = Float(bgColor.cgColor.components?[2] ?? 0)
        
        redNumber.text = string(from: redSlider)
        greenNumber.text = string(from: greenSlider)
        blueNumber.text = string(from: blueSlider)
        
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Создаем кнопку Done
        doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                     target: self,
                                     action: #selector(doneButtonTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        toolbar.items = [flexSpace, doneButton]
        
        // Устанавливаем тулбар в качестве inputAccessoryView
        redTextField.inputAccessoryView = toolbar
        greenTextField.inputAccessoryView = toolbar
        blueTextField.inputAccessoryView = toolbar
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func checkAndAdjustValue(forTextField
                                     textField: UITextField) -> Float? {
        if let inputText = textField.text, let floatValue = Float(inputText) {
            // Проверяем, находится ли значение между 0 и 1
            if floatValue < 0 {
                print("Введенное значение меньше 0")
                let newValue = max(floatValue, 0)
                print("Преобразованное значение: \(newValue)")
                return newValue
            } else if floatValue > 1 {
                print("Введенное значение больше 1")
                let newValue = min(floatValue, 1)
                print("Преобразованное значение: \(newValue)")
                return newValue
            } else {
                print("Введенное значение находится в диапазоне от 0 до 1")
                return floatValue
            }
        } else {
            print("Некорректный ввод")
            return nil
        }
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Создаем цифровую клавиатуру c разделителем
        let numericKeyboard = UIKeyboardType.decimalPad
        textField.keyboardType = numericKeyboard
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == redTextField {
            textField.resignFirstResponder()
            let newValue = checkAndAdjustValue(forTextField: redTextField)
            redSlider.value = newValue ?? redSlider.value
            redNumber.text = string(from: redSlider)
        } else if textField == greenTextField {
            textField.resignFirstResponder()
            let newValue = checkAndAdjustValue(forTextField: greenTextField)
            greenSlider.value = newValue ?? greenSlider.value
            greenNumber.text = string(from: greenSlider)
        } else {
            textField.resignFirstResponder()
            let newValue = checkAndAdjustValue(forTextField: blueTextField)
            blueSlider.value = newValue ?? blueSlider.value
            blueNumber.text = string(from: greenSlider)
        }
        setColor()
    }
}
