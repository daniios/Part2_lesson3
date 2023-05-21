//
//  StartViewController.swift
//  ColorizedApp
//
//  Created by Даниил Чупин on 22.05.2023.
//

import UIKit

protocol ColorSelectionDelegate: AnyObject {
    func didSelectColor(_ color: UIColor)
}

final class StartViewController: UIViewController {
    
    // MARK: - Life Cycles Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController
        else { return }
        settingsVC.bgColor = GetColor()
        settingsVC.delegate = self
    }
    
    // MARK: - Private methods
    private func GetColor() -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        if let backgroundColor = view.backgroundColor {
            backgroundColor.getRed(&red,
                                   green: &green,
                                   blue: &blue,
                                   alpha: &alpha)
        } else {
            print("Фон не установлен")
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK: - ColorSelectionDelegate
extension StartViewController: ColorSelectionDelegate {
    func didSelectColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
