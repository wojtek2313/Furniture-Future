//
//  ResetViewModel.swift
//  FurnitureFuture
//
//  Created by Wojtek on 04/11/2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import UIKit

class ResetViewModel: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegates
        mailTextField.delegate = self
        
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
        return true
    }
    
    @IBAction func resetButton(_ sender: Any) {
        ResetModel(mail: mailTextField.text!, vc: self).resetAdress()
    }
}
