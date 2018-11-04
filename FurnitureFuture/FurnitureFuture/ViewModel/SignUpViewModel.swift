//
//  SignUpViewModel.swift
//  FurnitureFuture
//
//  Created by Wojtek on 04/11/2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import UIKit

class SignUpViewModel: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    let signUpModel = SingUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegates
        mailTextField.delegate = self
        passTextField.delegate = self
        
        // gestures
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.goBack(sender:)))
        swipeDownGesture.direction = .down
        self.view.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc func goBack(sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mailTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func createButton(_ sender: Any) {
        signUpModel.createByFirebase(mail: mailTextField.text!, password: passTextField.text!
            , vc: self)
    }
}
