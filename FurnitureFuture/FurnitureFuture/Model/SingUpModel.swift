//
//  SingUpModel.swift
//  FurnitureFuture
//
//  Created by Wojtek on 04/11/2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit
import SCLAlertView
import iProgressHUD

class SingUpModel {
    var uid: String?
    
    func createByFirebase(mail: String, password: String, vc: UIViewController) {
        if mail != "" && password != "" {
            vc.view.showProgress()
            
            Auth.auth().createUser(withEmail: mail, password: password) { (user, error) in
                if error != nil {
                    _ = SCLAlertView().showError("Error!", subTitle:"\(String(describing: error!.localizedDescription))", closeButtonTitle:"OK")
                } else {
                    self.uid = Auth.auth().currentUser?.uid
                    vc.view.dismissProgress()
                    
                    vc.performSegue(withIdentifier: "SignUp", sender: nil)
                }
            }
        } else {
            vc.view.dismissProgress()
            _ = SCLAlertView().showError("Error!", subTitle: "Fill all of the gaps!", closeButtonTitle:"OK")
        }
    }
}
