//
//  ApiKeyViewController.swift
//  WeatherApp
//
//  Created by Selin KAPLAN on 23.04.2021.
//

import UIKit

class ApiKeyViewController: UIViewController {
    
    @IBOutlet weak var apiTextField: UITextField! {
        didSet {
            apiTextField.layer.borderWidth = 1
            apiTextField.layer.borderColor = UIColor(rgb: 0x8492A6).cgColor
            apiTextField.attributedPlaceholder = NSAttributedString(string: "API Key", attributes: [NSAttributedString.Key.foregroundColor:UIColor(rgb: 0x47525E)])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func enter(_ sender: Any) {
        
    }
    

}
