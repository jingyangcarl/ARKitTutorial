//
//  ViewController.swift
//  Tutorial08_Vehicle
//
//  Created by Jing Yang on 8/9/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit
import CoreMotion

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    let motionManager = CMMotionManager()
    var vehicle = SCNPhysicsVehicle()
    var orientation: CGFloat = 0
    var touched: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        self.setupAccelerometer()
        self.sceneView.showsStatistics = true
        // Do any additional setup after loading the view.
    }
    
    /*
     Description:
        This function is used to add concrete node, which is a static physics body
     Input:
        @ ARPlaneAnchor planeAnchor: a plane anchor
     Output:
        @ SCNNode returnValue: a concrete node
    */
    func createConcreteNode(planeAnchor: ARPlaneAnchor) -> SCNNode {
        let concreteNode = SCNNode(geometry: SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z)))
        concreteNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Concrete")
        concreteNode.geometry?.firstMaterial?.isDoubleSided = true
        concreteNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
        concreteNode.eulerAngles = SCNVector3(90.degreesToRadians, 0, 0)
        let staticBody = SCNPhysicsBody.static()
        concreteNode.physicsBody = staticBody
        return concreteNode
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
        let concreteNode = createConcreteNode(planeAnchor: planeAnchor)
        node.addChildNode(concreteNode)
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
        let concreteNode = createConcreteNode(planeAnchor: planeAnchor)
        node.addChildNode(concreteNode)
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
    
    @IBAction func addCar(_ sender: Any) {
        
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let currentPositionOfCamera = orientation + location
        
        let scene = SCNScene(named: "car.scn")
        let carNode = (scene?.rootNode.childNode(withName: "car", recursively: false))!
        carNode.position = currentPositionOfCamera
        let frontLeftWheel = carNode.childNode(withName: "frontLeftParent", recursively: false)!
        let frontRightWheel = carNode.childNode(withName: "frontRightParent", recursively: false)!
        let rearLeftWheel = carNode.childNode(withName: "rearLeftParent", recursively: false)!
        let rearRightWheel = carNode.childNode(withName: "rearRightParent", recursively: false)!
        
        let v_frontLeftWheel = SCNPhysicsVehicleWheel(node: frontLeftWheel)
        let v_frontRightWheel = SCNPhysicsVehicleWheel(node: frontRightWheel)
        let v_rearRightWheel = SCNPhysicsVehicleWheel(node: rearLeftWheel)
        let v_rearLeftWheel = SCNPhysicsVehicleWheel(node: rearRightWheel)

        let body = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: carNode, options: [SCNPhysicsShape.Option.keepAsCompound: true]))
        body.mass = 5
        carNode.physicsBody = body
        self.vehicle = SCNPhysicsVehicle(chassisBody: carNode.physicsBody!, wheels: [v_rearLeftWheel, v_rearRightWheel, v_frontLeftWheel, v_frontRightWheel])
        self.sceneView.scene.physicsWorld.addBehavior(self.vehicle)
        
        self.sceneView.scene.rootNode.addChildNode(carNode)
    }
    
    func setupAccelerometer() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1/60
            motionManager.startAccelerometerUpdates(to: .main, withHandler: {(accelerometerData, error) in
                if let error = error {
                    print(error)
                    return
                }
                self.accelerometerDidChange(acceleration: accelerometerData!.acceleration)
             })
        } else {
            
        }
    }
    
    func accelerometerDidChange(acceleration: CMAcceleration) {
        
        if acceleration.x > 0 {
            self.orientation = CGFloat(-acceleration.y)
        } else if acceleration.x < 0 {
            self.orientation = CGFloat(acceleration.y)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
        var engineForce: CGFloat = 0
        var brakingForce: CGFloat = 0
        self.vehicle.setSteeringAngle(-orientation, forWheelAt: 2)
        self.vehicle.setSteeringAngle(-orientation, forWheelAt: 3)
        
        if self.touched == 1 {
            engineForce = 50
        } else if self.touched == 2 {
            engineForce = -50
        } else if self.touched == 3 {
            brakingForce = 100
        } else {
            engineForce = 0
        }
        
        self.vehicle.applyEngineForce(engineForce, forWheelAt: 0)
        self.vehicle.applyEngineForce(engineForce, forWheelAt: 1)
        self.vehicle.applyBrakingForce(brakingForce, forWheelAt: 0)
        self.vehicle.applyBrakingForce(brakingForce, forWheelAt: 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let _ = touches.first else {return}
        self.touched += touches.count
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touched = 0
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
