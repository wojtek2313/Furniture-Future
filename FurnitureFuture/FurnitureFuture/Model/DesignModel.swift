//
//  DesignViewModel.swift
//  FurnitureFuture
//
//  Created by Wojtek on 04/11/2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import ARKit
import UIKit
import SCLAlertView
import Firebase
import FirebaseAuth

class DesignModel {
    
    func addOrRemove(sender: UIButton) -> Bool {
        if sender.currentImage! == UIImage(named: "AddBtn") {
            return true
        } else {
            return false
        }
    }
    
    func placeARObject(selectedItem: String?, hitTest: [ARHitTestResult], tapLocation: CGPoint, sceneView: ARSCNView) {
        let hitResult: ARHitTestResult?
        if !hitTest.isEmpty {
            print("touched a hroizontal")
            hitResult = hitTest.first!
            
            if selectedItem == nil {
                SCLAlertView().showInfo("Any Item Choosen", subTitle: "Choose item to decorate your room in: Menu>Add Furniture>Items")
            } else {
                if  let selectedItem = selectedItem {
                    let scene = SCNScene(named: "Models.scnassets/\(selectedItem).scn")
                    let node = scene?.rootNode.childNode(withName: selectedItem, recursively: false)
                let transform = hitResult!.worldTransform
                let thirdColumn = transform.columns.3
                node!.position = SCNVector3((thirdColumn.x), (thirdColumn.y), (thirdColumn.z))
                if node != nil {
                    sceneView.scene.rootNode.addChildNode(node!)
                } else {
                    _ = SCLAlertView().showError("Error!", subTitle:"There is a problem with the path for AR resources we are Appologize for this problem :)", closeButtonTitle:"OK")
                }
                }
            }
            
            
        } else {
            SCLAlertView().showInfo("No Match with the ground!", subTitle: "Lets aim your camera into the ground to put on it subjects!")
        }
    }
    
    func removeFromScene(hitTest: [SCNHitTestResult]) {
        if !hitTest.isEmpty {
            let results = hitTest.first!
            let node = results.node
            node.removeFromParentNode()
        } else {
            SCLAlertView().showError("Not Matched With Any Object!", subTitle: "To remove an object just direct your camera into the object and try to center it on the screen!", closeButtonTitle: "Ok")
        }
    }
    
    func scale3dModels(hitTest: [SCNHitTestResult], x: CGFloat, y: CGFloat, z: CGFloat) {
        if !hitTest.isEmpty {
            let results = hitTest.first!
            let node = results.node
            node.scale = SCNVector3( x, y, z)
        }
    }
    
    func showMenu(menuConstraint: NSLayoutConstraint!) {
        if menuConstraint.constant < 20.0 {
            UIView.animate(withDuration: 0.6, animations: {
                menuConstraint.constant = 20.0
            }, completion:  nil)
        } else {
            UIView.animate(withDuration: 0.6, animations: {
                menuConstraint.constant = -120.0
            }, completion:  nil)
        }
    }
    
    func showPhotoButton(photoButton: UIButton) {
        if photoButton.transform == CGAffineTransform(scaleX: 0.0, y: 0.0) {
            UIView.animate(withDuration: 0.6, animations: {
                photoButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }) { _ in
                UIView.animate(withDuration: 0.6, animations: {
                    photoButton.transform = CGAffineTransform.identity
                })
            }
        } else {
            UIView.animate(withDuration: 0.6, animations: {
                photoButton.transform = CGAffineTransform.identity
            }) { _ in
                UIView.animate(withDuration: 0.6, animations: {
                    photoButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                })
            }
        }
    }
    
    func editAddMode(addOrRemoveButton: UIButton, plusButton: UIButton, minusButton: UIButton, logo: UIView, menuButton: UIButton, navigationBar: UIView, line: UIView, ifEditMode: Bool, menuConstraint: NSLayoutConstraint) {
        if ifEditMode {
            
            logo.isHidden = false
            menuButton.isHidden = false
            navigationBar.isHidden = false
            line.isHidden = false
            
            UIView.transition(with: addOrRemoveButton, duration: 1.5, options: .transitionFlipFromBottom, animations: {
                addOrRemoveButton.setImage(UIImage(named: "RemoveBtn"), for: .normal)
            }, completion: nil)
            
            UIView.animate(withDuration: 0.6, animations: {
                plusButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }) { _ in
                UIView.animate(withDuration: 0.6, animations: {
                    plusButton.transform = CGAffineTransform.identity
                })
            }
            
            UIView.animate(withDuration: 0.6, animations: {
                minusButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }) { _ in
                UIView.animate(withDuration: 0.6, animations: {
                    minusButton.transform = CGAffineTransform.identity
                })
            }
        } else {
            
            logo.isHidden = true
            menuButton.isHidden = true
            navigationBar.isHidden = true
            line.isHidden = true
            
            if menuConstraint.constant == 20.0 {
                UIView.animate(withDuration: 0.6, animations: {
                    menuConstraint.constant = -120.0
                }, completion:  nil)
            }
            
            UIView.transition(with: addOrRemoveButton, duration: 1.5, options: .transitionFlipFromBottom, animations: {
                addOrRemoveButton.setImage(UIImage(named: "AddBtn"), for: .normal)
            }, completion: nil)
            
            UIView.animate(withDuration: 0.6, animations: {
                plusButton.transform = CGAffineTransform.identity
            }) { _ in
                UIView.animate(withDuration: 0.6, animations: {
                    plusButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                })
            }
            
            UIView.animate(withDuration: 0.6, animations: {
                minusButton.transform = CGAffineTransform.identity
            }) { _ in
                UIView.animate(withDuration: 0.6, animations: {
                    minusButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                })
            }
        }
    }
    
    func logOut (vc: UIViewController) {
        try! Auth.auth().signOut()
        vc.dismiss(animated: true, completion: nil)
    }
}
