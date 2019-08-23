//
//  ViewController.swift
//  Tutorial06_FloorIsLava
//
//  Created by Jing Yang on 8/9/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    /*
     Description:
        This function is used to generate a lava node based on where the plane is detected
     Input:
        @ ARPlaneAnchor planeAnchor: a plane anchor
     Output:
        @ SCNNode returnValue: a lava node
    */
    func createLavaNode(planeAnchor: ARPlaneAnchor) -> SCNNode {
        let lavaNode = SCNNode(geometry: SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z)))
        lavaNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Lava")
        lavaNode.geometry?.firstMaterial?.transparency = 0.5
        lavaNode.geometry?.firstMaterial?.isDoubleSided = true
        lavaNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
        lavaNode.eulerAngles = SCNVector3(90.degreesToRadians, 0, 0)
        return lavaNode
    }

    /*
     Description:
     This function is an interface from ARSCNViewDelegate, which is called whenever an ARAnchor is discovered, it adds a new ARAnchor to the scene
     Input:
        @ SCNSceneRenderer _ renderer: The ARSCNView object rendering the scene
        @ SCNNode didAdd node: the newly added ScneeKit node
        @ ARAnchor for anchor: the AR anchor corresponding to the node
     Output:
        @ nil returnValue: nil
    */
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // everytime we discover a horizontal surface, it adds a new AR plane anchor in didAdd
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        let lavaNode = createLavaNode(planeAnchor: planeAnchor)
        node.addChildNode(lavaNode)
    }
    
    /*
     Description:
        This function is an interface from ARSCNViewDelegate, which is called whenever the device discovers more of the same horizontal surface, it updates the AR anchor
     Input:
        @ SCNSceneRenderer _ renderer: The ARSCNView object rendering the scene
        @ SCNNode didUpdate node: the updated ScneeKit node
        @ ARAnchor for anchor: the AR anchor corresponding to the node
     Output:
        @ nil returnValue: nil
    */
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // whenever the device discovers more of the same horizontal surface, it updates the surface plane anchor
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        node.enumerateChildNodes{ (childNode, _) in
            childNode.removeFromParentNode()
        }
        let lavaNode = createLavaNode(planeAnchor: planeAnchor)
        node.addChildNode(lavaNode)
    }
    
    /*
     Description:
        This function is an interface from ARSCNViewDelegate, which is called whenever the device adds more than one plane anchor for the same horizontal surface, it removes it.
     Input:
        @ SCNSceneRenderer _ renderer: The ARSCNView object rendering the scene
        @ SCNNode didRemove node: the removed SceneKit node
        @ ARAnchor for anchor: the AR anchor corresponding to the node
     Output:
        @ nil returnValue: nil
    */
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        // when there is a error, and the device adds more than one plane anchor for the same horizontal surface, it removes and calls didRemove
        guard let _ = anchor as? ARPlaneAnchor else {return}
        node.enumerateChildNodes{ (childNode, _) in
            childNode.removeFromParentNode()
        }
    }

}

extension Int {
    /*
     Description:
        This function is used to convert degrees to radians
     Input:
        @ double parameter: a degree value
     Output:
        @ double returnValue: a radian value
     */
    var degreesToRadians: Double {
        return Double(self) * .pi/180
    }
}
