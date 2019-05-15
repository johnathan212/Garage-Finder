//
//  NewListingViewController.swift
//  
//
//  Created by Johnathan Lee on 5/14/19.
//

import UIKit

class NewListingViewController: UIViewController {
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressField.delegate = self
        priceField.delegate = self
        emailField.delegate = self
        phoneNumField.delegate = self
    }
    
    @IBAction func submitTapped(_ sender: Any){
        print("addressField.text")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNumField.resignFirstResponder()
    }
}

extension UIViewController : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
