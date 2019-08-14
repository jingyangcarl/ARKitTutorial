//
//  ViewController.swift
//  Tutorial11_ARHoops
//
//  Created by Jing Yang on 8/13/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit
import Each

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var labelPlaneDetected: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    var basketAdded: Bool = false
    var power: Float = 1
    var timer = Each(0.05).seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.cancelsTouchesInView = false
        // Do any additional setup after loading the view.
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
        guard anchor is ARPlaneAnchor else {return}
        DispatchQueue.main.async {
            self.labelPlaneDetected.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.labelPlaneDetected.isHidden = true
        }
    }

    /*
     Description:
        This function is used to handle tap events
     Input:
        @ UITapGestureRecognizer sender: a gesture recognizer
     */
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else {return}
        let touchLocation = sender.location(in: sceneView)
        let hitTestResult = sceneView.hitTest(touchLocation, types: [.existingPlaneUsingExtent])
        if !hitTestResult.isEmpty {
            self.addBasket(hitTestResult: hitTestResult.first!)
        } else {
            
        }
    }
    
    /*
     Description:
        This function is used to load scene and display the basket
     Input:
        @ ARHitTestResult hitTestResult: a hit test result
     Output:
        @ nil returnValue: nil
    */
    func addBasket(hitTestResult: ARHitTestResult) {
        if basketAdded == false {
            let basketScene = SCNScene(named: "Basketball.scnassets/Basketball.scn")
            let basketNode = basketScene?.rootNode.childNode(withName: "Basket", recursively: false)
            let positionOfPlane = hitTestResult.worldTransform.columns.3
            let x = positionOfPlane.x
            let y = positionOfPlane.y
            let z = positionOfPlane.z
            basketNode?.position = SCNVector3(x, y, z)
            basketNode?.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: basketNode!, options: [SCNPhysicsShape.Option.keepAsCompound: true, SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron]))
            self.sceneView.scene.rootNode.addChildNode(basketNode!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.basketAdded = true
            }
        }
    }
    
    /*
     Description:
        This function is used to deal with touches began, which is used to control the power of ball shooting
     Input:
        @ Set<UITouch> _ touches: touches on the screen
        @ UIEvent? with event: UIEvent
     Output:
        @ nil returnValue: nil
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.basketAdded == true {
            // there is a basket
            timer.perform(closure: { () -> NextStep in
                self.power = self.power + 1
                return .continue
            })
        }
    }
    
    /*
     Description:
        This function is used to deal with touches ended, which is used to reset the power of ball shooting
     Input:
        @ Set<UITouch> _ touches: touches on the screen
        @ UIEvent? with event: UIEvent
     Output:
        @ nil returnValue: nil
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.basketAdded == true {
            self.timer.stop()
            self.shootBall()
        }
        self.power = 1
    }
    
    /*
     Description:
        This function is used to control how to shoot the ball
     Input:
        @ nil parameter: nil
     Output:
        @ nil returnValue: nil
    */
    func shootBall(){
        guard let pointOfView = self.sceneView.pointOfView else {return}
        self.removeEveryOtherBall()
        let transform = pointOfView.transform
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let position = location + orientation
        let ball = SCNNode(geometry: SCNSphere(radius: 0.2))
        ball.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Ball")
        ball.position = position
        let body = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: ball))
        ball.physicsBody = body
        ball.name = "basketball"
        body.restitution = 0.2
        ball.physicsBody?.applyForce(SCNVector3(orientation.x*power, orientation.y*power, orientation.z*power), asImpulse: true)
        self.sceneView.scene.rootNode.addChildNode(ball)
    }
    
    /*
     Description:
        This function is used to remove all the balls from current scene
     Input:
        @ nil parameter: nil
     Output:
        @ nil returnValue: nil
    */
    func removeEveryOtherBall() {
        self.sceneView.scene.rootNode.enumerateChildNodes{ (node, _) in
            if node.name == "basketball" {
                node.removeFromParentNode()
            }
        }
    }
    
    deinit {
        self.timer.stop()
    }
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y+right.y, left.z+right.z)
}
