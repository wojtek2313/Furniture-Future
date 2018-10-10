//
//  LoginSignInModel.swift
//  FurnitureFuture
//
//  Created by Wojtek on 08/10/2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SCLAlertView

class LoginModel {
    func logIn(mail: String, pass: String, vc: UIViewController){
        if mail != "" && pass != "" {
            Auth.auth().signIn(withEmail: mail, password: pass) { (user, error) in
                if error != nil {
                    SCLAlertView().showError("Error!", subTitle: "\(error!.localizedDescription)", closeButtonTitle: "OK")
                } else {
                    SCLAlertView().showSuccess("Congratulations!", subTitle: "You are logged in!")
                    sleep(2)
                    vc.performSegue(withIdentifier: "LogIn", sender: nil)
                }
            }
        } else {
            SCLAlertView().showError("Error!", subTitle: "Fill all of the gaps!", closeButtonTitle: "OK")
        }
    }
}
