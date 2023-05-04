//
//  ViewController.swift
//  Part2_lesson3
//
//  Created by Даниил Чупин on 04.05.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - IB outlets
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redNumber: UILabel!
    @IBOutlet weak var greenNumber: UILabel!
    @IBOutlet weak var blueNumber: UILabel!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        setColor()
        redNumber.text = string(from: redSlider)
        greenNumber.text = string(from: greenSlider)
        blueNumber.text = string(from: blueSlider)
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
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1.00)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }

}

