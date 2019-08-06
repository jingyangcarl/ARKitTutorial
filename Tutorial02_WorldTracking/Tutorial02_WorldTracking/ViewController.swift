//
//  ViewController.swift
//  Tutorial02_WorldTracking
//
//  Created by qingguo xu on 8/6/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }

    /*
     Description:
        This function is a callback funciton for button Add
     Input:
        @ Any: sender
     */
    @IBAction func ButtonAdd(_ sender: Any) {
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        let x = RandomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = RandomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = RandomNumbers(firstNum: -0.3, secondNum: 0.3)
        node.position = SCNVector3(x, y, z)
        node.eulerAngles = SCNVector3(0.0, Float(45.degreesToRadians), 0.0)
        self.sceneView.scene.rootNode.addChildNode(node)
        
        // a roofNode with relative position (roofOffX, roofOffY, roofOffZ)
        let roofNode = SCNNode()
        roofNode.geometry = SCNPyramid(width: 0.13, height: 0.07, length: 0.13)
        roofNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        roofNode.geometry?.firstMaterial?.specular.contents = UIColor.white
        let roofOffX = 0.0
        let roofOffY = 0.1 / 2
        let roofOffZ = 0.0
        roofNode.position = SCNVector3(roofOffX, roofOffY, roofOffZ)
        node.addChildNode(roofNode)
        
        // a doorNode with relative position ()
        let doorNode = SCNNode()
        doorNode.geometry = SCNPlane(width: 0.03, height: 0.06)
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        doorNode.geometry?.firstMaterial?.specular.contents = UIColor.white
        let doorOffX = 0.0
        let doorOffY = -(0.1 - 0.06) / 2
        let doorOffZ = 0.1 / 2 + 0.0001
        doorNode.position = SCNVector3(doorOffX, doorOffY, doorOffZ)
        node.addChildNode(doorNode)
    }
    
    /*
     Description:
        This function is a callback funciton for button Reset
     Input:
        @ Any: sender
     */
    @IBAction func ButtonReset(_ sender: Any) {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    /*
     Description:
        This function is used to generate a random number between a given range
     Input:
        @ CGFloat firstNum: minimum of the range
        @ CGFloat secondNum: maximum of the range
     Output:
        @ CGFloat returnValue: a random number
     */
    func RandomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

extension Int{
    var degreesToRadians: Double{
        return Double(self) * .pi/180
    }
}
