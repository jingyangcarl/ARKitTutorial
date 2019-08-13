//
//  ViewController.swift
//  Tutorial03_ARDrawing
//
//  Created by Jing Yang on 8/6/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var buttonDraw: UIButton!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        // Do any additional setup after loading the view.
    }

    /*
     Description:
        This function is used to tell the delegate that the renderer has cleared the viewport and is about to render to scene. In this case, if the button is pushed, spheres will be continuously placed at where the camera is, if the button is not pushed, a sphere (marker) will be placed at where the camera and then removed.
     Input:
        @ SCNSceneRenderer _ renderer: a renderer
        @ SCNScene willRenderScene scene: a scene to be rendered
        @ TimeInterval atTime time: the current system time
     Output:
        @ nil returnValue: nil
    */
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        
        // orientation is the direction camera look at
        // if the camera looks along the positive direction of x axis, the orientation should be (1.0, 0.0, 0.0)
        // if the camera looks along the negative direction of x axis, the orientation should be (-1.0, 0.0, 0.0)
        // if the camera looks along the positive direction of y axis, the orientation should be (0.0, 1.0, 0.0)
        // if the camera looks along the negative direction of y axis, the orientation should be (0.0, -1.0, 0.0)
        // if the camera looks along the positive direction of z axis, the orientation shoudl be (0.0, 0.0, 1.0)
        // if the camera looks along the negative direction of z axis, the orientation should be (0.0, 0.0, -1.0)
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        
        // location is how far is the camera from the origin
        // if the camera moves along the positive direction of x axis, the location should step to (1.0, 0.0, 0.0)
        // if the camera moves along the negative direction of x axis, the location should step to (-1.0, 0.0, 0.0)
        // if the camera moves along the positive direction of y axis, the location should step to (0.0, 1.0, 0.0)
        // if the camera moves along the negative direction of y axis, the location should step to (0.0, -1.0, 0.0)
        // if the camera moves along the positive direction of z axis, the location should step to (0.0, 0.0, 1.0)
        // if the camera moves along the negative direction of z axis, the location should step be (0.0, 0.0, -1.0)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let currentPositionOfCamera = orientation + location
        
        // let this run in main thread
        DispatchQueue.main.async {
            if self.buttonDraw.isHighlighted {
                // if the button is pressed
                let node = SCNNode(geometry: SCNSphere(radius: 0.02))
                node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
                node.position = currentPositionOfCamera
                self.sceneView.scene.rootNode.addChildNode(node)
            } else{
                // if the button is not pressed
                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
                pointer.name = "pointer"
                pointer.position = currentPositionOfCamera
                
                self.sceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if node.name == "pointer" {
                        node.removeFromParentNode()
                    }
                })
                
                self.sceneView.scene.rootNode.addChildNode(pointer)
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.white
            }
        }
    }

}

/*
 Description:
    This function is used to overwrite + operator for vector add
 Input:
    @ SCNVector3 left: left handside operand
    @ SCNVector3 right: right handsice operand
 Output:
    @ SCNVector3 returnValue: left + right
 */
func +(left: SCNVector3, right: SCNVector3) -> SCNVector3{
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}
