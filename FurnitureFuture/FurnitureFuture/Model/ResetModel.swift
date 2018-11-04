//
//  ResetModel.swift
//  FurnitureFuture
//
//  Created by Wojtek on 04/11/2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SCLAlertView

class ResetModel {
    let mail: String
    let vc: UIViewController
    var auth = Auth.auth()
    
    init(mail: String, vc: UIViewController) {
        self.mail = mail
        self.vc = vc
    }
    
    func resetAdress() {
        auth.sendPasswordReset(withEmail: mail) { (error) in
            if error != nil {
                _ = SCLAlertView().showError("Error!", subTitle: error!.localizedDescription, closeButtonTitle: "OK")
            } else {
                self.vc.dismiss(animated: true, completion: nil)
            }
        }
    }
}
