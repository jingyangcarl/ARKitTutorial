//
//  ViewController.swift
//  Tutorial05_WhackAJellyfish
//
//  Created by Jing Yang on 8/7/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var buttonPlay: UIButton!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }

    @IBAction func ButtonPlay(_ sender: Any) {
        self.addNode()
        self.buttonPlay.isEnabled = false
    }
    
    @IBAction func ButtonReset(_ sender: Any) {
        
    }
    
    func addNode(){
        let jellyfishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let jellyfishNode = jellyfishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        let x = RandomNumbers(firstNum: -1.0, secondNum: 1.0)
        let y = RandomNumbers(firstNum: -1.0, secondNum: 1.0)
        let z = RandomNumbers(firstNum: -1.0, secondNum: 1.0)
        jellyfishNode?.position = SCNVector3(x, y, z)
        self.sceneView.scene.rootNode.addChildNode(jellyfishNode!)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        
        if hitTest.isEmpty {
            print("didn't touch anything")
        } else {
            let results = hitTest.first!
            let node = results.node
            if node.animationKeys.isEmpty {
                // only if the animationKeys is empty, unless the continuous touching will destrop the animation
                SCNTransaction.begin()
                self.animateNode(node: results.node)
                SCNTransaction.completionBlock = {
                    node.removeFromParentNode()
                    self.addNode()
                }
                SCNTransaction.commit()
            }
        }
    }
    
    func animateNode(node: SCNNode) {
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = node.presentation.position
        spin.toValue = SCNVector3(node.presentation.position.x - 0.2, node.presentation.position.y - 0.2, node.presentation.position.z - 0.2)
        spin.duration = 0.1
        spin.autoreverses = true
        spin.repeatCount = 5
        node.addAnimation(spin, forKey: "position")
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


