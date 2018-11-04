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
    
    // Constants
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // AR Configuration
        self.sceneView.debugOptions = [ ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        self.sceneView.autoenablesDefaultLighting = true
    }
}
