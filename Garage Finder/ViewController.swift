//
//
//
//  Created by Johnathan Lee on 5/14/19.
//

import UIKit
import FirebaseDatabase

class NewListingViewController: UIViewController {
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumField: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        addressField.delegate = self
        priceField.delegate = self
        emailField.delegate = self
        phoneNumField.delegate = self
    }
    //add textfield input to firebase database
    @IBAction func submitTapped(_ sender: Any){
        let post = [
            "Address": addressField.text,
            "Price": priceField.text,
            "Email": emailField.text,
            "Phone": phoneNumField.text
        ]
        ref.child("listings").childByAutoId().setValue(post)
        addressField.text = ""
        priceField.text = ""
        emailField.text = ""
        phoneNumField.text = ""
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


