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
    
    var bgColor: UIColor!
    unowned var delegate: ColorSelectionDelegate!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        setupFromMain()
    }
    
    // MARK: - IB actions
    @IBAction func rgbSlider(_ sender:UISlider) {
        setColor()
        
        switch sender {
        case redSlider:
            redNumber.text = string(from: redSlider)
        case greenSlider:
            greenNumber.text = string(from: greenSlider)
        default:
            blueNumber.text = string(from: blueSlider)
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
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }

}

