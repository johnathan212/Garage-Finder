//
//
//
//  Created by Johnathan Lee on 5/14/19.
//

import UIKit
import Firebase

class NewListingViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumField: UITextField!
    
    //upload image
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func uploadImageButton(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            //after completion
        }
    }
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        } else {
            print("image error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
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
        var uniqueID = UUID().uuidString
        uniqueID += ".jpg"
        let listing = [
            "Address": addressField.text as String?,
            "Price": priceField.text as String?,
            "Email": emailField.text as String?,
            "Phone": phoneNumField.text as String?,
            "Image": uniqueID]
        ref.child("listings").childByAutoId().setValue(listing)
        addressField.text = ""
        priceField.text = ""
        emailField.text = ""
        phoneNumField.text = ""
        
        guard let image = imageView.image else { return}
        guard let imageData = image.jpegData(compressionQuality: 0) else { return}
        
        let uploadImageRef = imageReference.child(uniqueID)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        let uploadTask = uploadImageRef.putData(imageData, metadata: metaData)
        
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "done")
        }
        uploadTask.resume()
        
        imageView.image = nil
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


