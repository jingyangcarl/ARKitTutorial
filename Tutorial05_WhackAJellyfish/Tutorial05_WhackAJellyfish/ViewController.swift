//
//  ViewController.swift
//  Tutorial05_WhackAJellyfish
//
//  Created by Jing Yang on 8/7/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit
import Each

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var buttonPlay: UIButton!
    let configuration = ARWorldTrackingConfiguration()
    var timer = Each(1).seconds
    var countdown = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.session.run(configuration)
        
        // add tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    /*
     Description:
        This function is used to handle tap events
     Input:
        @ UITapGestureRecognizer sender: a gesture recognizer
     */
    @objc func handleTap(sender: UITapGestureRecognizer){
        
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        
        if hitTest.isEmpty {
            // touch nothing
        } else {
            // touch the object
            if countdown > 0 {
                let results = hitTest.first!
                let node = results.node
                if node.animationKeys.isEmpty {
                    // only if the animationKeys is empty, unless the continuous touching will destrop the animation
                    SCNTransaction.begin()
                    self.animateNode(node: results.node)
                    SCNTransaction.completionBlock = {
                        node.removeFromParentNode()
                        self.addNode()
                        self.RestoreTiemr()
                    }
                    SCNTransaction.commit()
                }
            }
        }
    }

    /*
     Description:
        This function is the callback function of button Play, which is used to trigger the timer and generate jellyfish
     Input:
        @ Any _ sender: any sender
    */
    @IBAction func ButtonPlay(_ sender: Any) {
        self.SetTimer()
        self.addNode()
        self.buttonPlay.isEnabled = false
    }
    
    /*
     Description:
        This function is the callback function of button Reset, which is used to remove all jellyfish nodes from the scene and reset the timer
     Input:
        @ Any _ sender: any sender
     */
    @IBAction func ButtonReset(_ sender: Any) {
        self.timer.stop()
        self.RestoreTiemr()
        self.labelTimer.text = "Let's Play"
        self.buttonPlay.isEnabled = true
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
    }
    
    /*
     Description:
        This function is used to add a node to the sceneView
     Input:
        @ nil parameter: nil
     Output:
        @ nil returnValue: nil
    */
    func addNode(){
        // the jellyfish model can be found on the following link:
        // https://www.turbosquid.com
        let jellyfishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let jellyfishNode = jellyfishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        let x = RandomNumbers(firstNum: -0.5, secondNum: 0.5)
        let y = RandomNumbers(firstNum: -0.5, secondNum: 0.5)
        let z = RandomNumbers(firstNum: -0.5, secondNum: -1.0)
        jellyfishNode?.position = SCNVector3(x, y, z)
        self.sceneView.scene.rootNode.addChildNode(jellyfishNode!)
    }
    
    /*
     Description:
        This function is used to generate animation for a given node
     Input:
        @ SCNNode node: a given node
     Output:
        @ nil returnValue: nil
    */
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
        This function is used to generate a random number from a given range
     Input:
        @ CGFloat firstNum: minimum of the range
        @ CGFloat secondNum: maximum of the range
     Output:
        @ CGFloat returnValue: a random number
     */
    func RandomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    /*
     Description:
        This function is used to set a timer
     Input:
        @ nil paramter: nil
     Output:
        @ nil returnValue: nil
    */
    func SetTimer() {
        self.timer.perform{ () -> NextStep in
            self.countdown -= 1
            self.labelTimer.text = "Countdown: " + String(self.countdown)
            if self.countdown == 0 {
                self.labelTimer.text = "You Lose"
                return .stop
            }
            return .continue
        }
    }
    
    /*
     Description:
        This function is used to reset the timer
     Input:
        @ nil paramter: nil
     Output:
        @ nil returnValue: nil
     */
    func RestoreTiemr() {
        self.countdown = 10
        self.labelTimer.text = "Countdown: " + String(self.countdown)
    }
}


