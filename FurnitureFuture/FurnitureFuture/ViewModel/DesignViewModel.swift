//
//  DesignViewModel.swift
//  FurnitureFuture
//
//  Created by Wojtek on 04/11/2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import UIKit
import ARKit

class DesignViewModel: UIViewController, ARSCNViewDelegate {
    
    // Outlets
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var addOrRemoveButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var menuConstraint: NSLayoutConstraint!
    
    
    // Constants
    let designModel = DesignModel()
    let configuration = ARWorldTrackingConfiguration()
    var selectedItem = "cup"
    var tapGesture: UITapGestureRecognizer!
    var arScale: CGFloat = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.isHidden = true
        menuButton.isHidden = true
        navigationBar.isHidden = true
        line.isHidden = true
        
        self.minusButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        self.plusButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        // AR Configuration
        self.sceneView.debugOptions = [ ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        self.sceneView.autoenablesDefaultLighting = true
        
        // Gesture Recognizers
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func addOrRemoveFurniturePressed(_ sender: Any) {
        if designModel.addOrRemove(sender: addOrRemoveButton) {
            let tapLocation = CGPoint(x: sceneView.frame.width / 2 , y: sceneView.frame.height / 2)
            let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
            designModel.placeARObject(selectedItem: selectedItem, hitTest: hitTest, tapLocation: tapLocation, sceneView: self.sceneView)
        } else {
            let tapLocation = CGPoint(x: sceneView.frame.width / 2 , y: sceneView.frame.height / 2)
            let hitTest = sceneView.hitTest(tapLocation)
            designModel.removeFromScene(hitTest: hitTest)
        }
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        designModel.showMenu(menuConstraint: menuConstraint)
    }
    
    @IBAction func takeAPhotoButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        designModel.logOut(vc: self)
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        let tapLocation = CGPoint(x: sceneView.frame.width / 2 , y: sceneView.frame.height / 2)
        let hitTest = sceneView.hitTest(tapLocation)
        arScale += 0.1
        designModel.scale3dModels(hitTest: hitTest, x: arScale, y: arScale, z: arScale)
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        let tapLocation = CGPoint(x: sceneView.frame.width / 2 , y: sceneView.frame.height / 2)
        let hitTest = sceneView.hitTest(tapLocation)
        arScale -= 0.1
        designModel.scale3dModels(hitTest: hitTest, x: arScale, y: arScale, z: arScale)
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        tapGesture = sender
        designModel.editAddMode(addOrRemoveButton: addOrRemoveButton, plusButton: plusButton, minusButton: minusButton, logo: logo, menuButton: menuButton, navigationBar: navigationBar, line: line, ifEditMode: designModel.addOrRemove(sender: addOrRemoveButton))
    }
}
