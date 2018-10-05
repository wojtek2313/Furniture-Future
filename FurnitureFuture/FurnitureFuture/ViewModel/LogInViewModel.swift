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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegates:
        mailTextfield.delegate = self
        passTextfield.delegate = self
        
        // gestures:
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.goBack(sender:)))
        swipeUpGesture.direction = .down
        self.view.addGestureRecognizer(swipeUpGesture)
    }
    
    @objc func goBack(sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mailTextfield.resignFirstResponder()
        passTextfield.resignFirstResponder()
        return true
    }
}
