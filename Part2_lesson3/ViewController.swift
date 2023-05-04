//
//  ViewController.swift
//  Part2_lesson3
//
//  Created by Даниил Чупин on 04.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB outlets
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redNumber: UILabel!
    @IBOutlet var greenNumber: UILabel!
    @IBOutlet var blueNumber: UILabel!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        colorChange()
    }
    
    // MARK: - IB actions
    @IBAction func rgbSlider (_ sender:UISlider) {
        colorChange()
    }
    
    // MARK: - Private methods
    private func colorChange() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1.00)
        redNumber.text = String(format: "%.2f", redSlider.value)
        greenNumber.text = String(format: "%.2f", greenSlider.value)
        blueNumber.text = String(format: "%.2f", blueSlider.value)
    }

}

