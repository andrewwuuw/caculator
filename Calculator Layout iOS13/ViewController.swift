//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultUILabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        if let resultValue = resultUILabel.text,
            let senderValue = sender.currentTitle {
            resultUILabel.text = (resultValue == "0") ? senderValue : resultValue + senderValue
        }
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        if let resultValue = resultUILabel.text, !resultValue.contains(".") {
            resultUILabel.text = resultValue + "."
        }
    }
    
    @IBAction func percentagePressed(_ sender: UIButton) {
        if let resultValue = convertToDouble(&resultUILabel.text) {
            resultUILabel.text = String(resultValue/100)
        }
    }
    
    @IBAction func positiveNegativePressed(_ sender: UIButton) {
        guard let doubleValue = convertToDouble(&resultUILabel.text) else { return }
        guard let intValue = convertToInteger(&resultUILabel.text) else { return }
        if let resultValue = resultUILabel.text {
            if (resultValue.contains(".")) {
                resultUILabel.text = String(-doubleValue)
            } else {
                resultUILabel.text = String(-intValue)
            }
        }
    }
    
    @IBAction func acPressed(_ sender: UIButton) {
        resultUILabel.text = "0"
    }
    
    @IBAction func methodPressed(_ sender: UIButton) {
        if let resultValue = resultUILabel.text,
            let senderValue = sender.currentTitle {
            let lastString = String(Array(resultValue)[Array(resultValue).count-1])
            if (lastString != "+") && (lastString != "-") && (lastString != "×") && (lastString != "÷") {
                resultUILabel.text = resultValue + senderValue
            } else if (lastString == "+") || (lastString == "-") || (lastString == "×") || (lastString == "÷") {
                // TODO: - 點選其他 method 要能切換
            }
        }
    }
    
    //MARK: - Private Functions
    private func convertToDouble<T>(_ a:inout T) -> Double? {
        return (a as? NSString)?.doubleValue
    }
    
    private func convertToInteger<T>(_ a:inout T) -> Int? {
        return (a as? NSString)?.integerValue
    }
}

