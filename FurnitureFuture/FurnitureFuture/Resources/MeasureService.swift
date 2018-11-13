//
//  MeasureService.swift
//  FurnitureFuture
//
//  Created by Wojtek on 13/11/2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import ARKit
import UIKit

class MeasureService: NSObject {
    
    static func addChildNode(_ node: SCNNode, toNode: SCNNode, inView: ARSCNView, cameraRelativePosition: SCNVector3) {
        guard let currentFrame = inView.session.currentFrame else { return }
        let camera = currentFrame.camera
        let transform = camera.transform
        var translationMatrix = matrix_identity_float4x4
        translationMatrix.columns.3.x = cameraRelativePosition.x
        translationMatrix.columns.3.y = cameraRelativePosition.y
        translationMatrix.columns.3.z = cameraRelativePosition.z
        
        let theModifiedMatrix = simd_mul(transform, translationMatrix)
        node.simdTransform = theModifiedMatrix
        toNode.addChildNode(node)
    }
    
    static func distance3(fromStartingPositionNode: SCNNode?, onView: ARSCNView, cameraRelativePostion: SCNVector3, toEndingPosition: SCNNode?) -> SCNVector3? {
        guard let startingPosition = fromStartingPositionNode else { return nil }
        guard let currentFrame = onView.session.currentFrame else { return nil }
        let camera = currentFrame.camera
        let transform = camera.transform
        var translationMatrix = matrix_identity_float4x4
        translationMatrix.columns.3.x = cameraRelativePostion.x
        translationMatrix.columns.3.y = cameraRelativePostion.y
        translationMatrix.columns.3.z = cameraRelativePostion.z
        let theModifiedMatrix = simd_mul(transform, translationMatrix)
        let xDistance = theModifiedMatrix.columns.3.x
        let yDistance = theModifiedMatrix.columns.3.y
        let zDistance = theModifiedMatrix.columns.3.z
        return SCNVector3(xDistance, yDistance, zDistance)
    }
    
    static func distance(x:Float, y:Float, z:Float) -> Float {
        return (sqrt(x*x + y*y + z*z))
    }
}
