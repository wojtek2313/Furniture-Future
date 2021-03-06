//
//  LogInViewModel.swift
//  FurnitureFuture
//
//  Created by Wojtek on 05/10/2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import UIKit

class LogInViewModel: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mailTextfield: UITextField!
    @IBOutlet weak var passTextfield: UITextField!
    
    let loginModel = LoginModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegates:
        mailTextfield.delegate = self
        passTextfield.delegate = self
        
        // gestures:
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.goBack(sender:)))
        swipeDownGesture.direction = .down
        self.view.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc func goBack(sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mailTextfield.resignFirstResponder()
        passTextfield.resignFirstResponder()
        return true
    }
    
    @IBAction func startButton(_ sender: Any) {
        loginModel.logIn(mail: mailTextfield.text!, pass: passTextfield.text!, vc: self)
    }
}
