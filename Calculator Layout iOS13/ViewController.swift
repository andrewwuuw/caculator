//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

enum MethodType {
    case add
    case minus
    case mutiply
    case divided
    case none
}

class ViewController: UIViewController {
    //MARK: - Variable
    var screenNumber: Double = 0
    var previousNumber: Double = 0
    var isCalculating: Bool = false
    var method: MethodType = .none
    var reset = true
    
    //MARK: - Outlet
    @IBOutlet weak var resultUILabel: UILabel!

    //MARK: - Actions
    @IBAction func numberPressed(_ sender: UIButton) {
        guard let resultValue = resultUILabel.text else { return }
        guard let senderValue = sender.currentTitle else { return }
        
        if (reset) {
            resultUILabel.text = senderValue
            reset = false
        } else {
            if (resultValue == "0") || (resultValue == "+") || (resultValue == "-") || (resultValue == "×") || (resultValue == "÷") {
                resultUILabel.text = senderValue
            } else {
                resultUILabel.text = resultValue + senderValue
            }
        }

        screenNumber = convertToDouble(&resultUILabel.text) ?? 0
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        if let resultValue = resultUILabel.text, !resultValue.contains(".") {
            resultUILabel.text = resultValue + "."
        }
    }
    
    @IBAction func percentagePressed(_ sender: UIButton) {
        guard let resultValue = convertToDouble(&resultUILabel.text) else { return }
        
        resultUILabel.text = String(resultValue/100)
    }
    
    @IBAction func invertPressed(_ sender: UIButton) {
        guard let doubleValue = convertToDouble(&resultUILabel.text) else { return }
        guard let intValue = convertToInteger(&resultUILabel.text) else { return }
        guard let resultValue = resultUILabel.text else { return }
        
        resultUILabel.text = (resultValue.contains(".")) ? String(-doubleValue) : String(-intValue)
    }
    
    @IBAction func acPressed(_ sender: UIButton) {
        resultUILabel.text = "0"
        screenNumber = 0
        previousNumber = 0
        isCalculating = false
        method = .none
        reset = true
    }
    
    @IBAction func methodPressed(_ sender: UIButton) {
        guard let senderValue = sender.currentTitle else { return }
        
        resultUILabel.text = senderValue
        isCalculating = true
        previousNumber = screenNumber
        
        switch senderValue {
        case "+":
            method = .add
        case "-":
            method = .minus
        case "×":
            method = .mutiply
        case "÷":
            method = .divided
        default:
            method = .none
        }
    }
    
    @IBAction func equalsPressed(_ sender: UIButton) {
        if (isCalculating) {
            switch method {
            case .add:
                setResultValue(from: (previousNumber + screenNumber))
            case .minus:
                setResultValue(from: (previousNumber - screenNumber))
            case .mutiply:
                setResultValue(from: (previousNumber * screenNumber))
            case .divided:
                setResultValue(from: (previousNumber / screenNumber))
            case .none:
                resultUILabel.text = "0"
            }
            isCalculating = false
            reset = true
        }
    }
    
    //MARK: - View loading
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Private
    
    private func convertToDouble<T>(_ a:inout T) -> Double? {
        return (a as? NSString)?.doubleValue
    }
    
    private func convertToInteger<T>(_ a:inout T) -> Int? {
        return (a as? NSString)?.integerValue
    }
    
    private func setResultValue(from number: Double) {
        var resultValue: String
        
        resultValue = (floor(number) == number) ? "\(Int(number))" : "\(number)"
        resultUILabel.text = (resultValue.count > 10) ? String(resultValue.prefix(10)) : resultValue
    }
}

