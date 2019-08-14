//
//  ViewController.swift
//  Tutorial10_ARPortal
//
//  Created by Jing Yang on 8/13/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var labelPlaneDetected: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            // make sure all UI updates happen in main thread
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
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        if !hitTestResult.isEmpty {
            // add our room
            self.addPortal(hitTestResult: hitTestResult.first!)
        } else {
            
        }
    }
    
    /*
     Description:
        This function is used to load scene and load skybox
     Input:
        @ ARHitTestResult hitTestResult: a hit test result
     Output:
        @ nil returnValue: nil
    */
    func addPortal(hitTestResult: ARHitTestResult){
        let portalScene = SCNScene(named: "Portal.scnassets/Portal.scn")
        let portalNode = portalScene!.rootNode.childNode(withName: "Portal", recursively: false)!
        let transform = hitTestResult.worldTransform
        let planeX = transform.columns.3.x
        let planeY = transform.columns.3.y
        let planeZ = transform.columns.3.z
        portalNode.position = SCNVector3(planeX, planeY, planeZ)
        self.sceneView.scene.rootNode.addChildNode(portalNode)
        self.addPlane(nodeName: "glPosY", portalNode: portalNode, imageName: "posy")
        self.addPlane(nodeName: "glNegY", portalNode: portalNode, imageName: "negy")
        self.addWall(nodeName: "glNegZ", portalNode: portalNode, imageName: "negz")
        self.addWall(nodeName: "glPosZLeft", portalNode: portalNode, imageName: "posz")
        self.addWall(nodeName: "glPosZRight", portalNode: portalNode, imageName: "posz")
        self.addWall(nodeName: "glNegX", portalNode: portalNode, imageName: "negx")
        self.addWall(nodeName: "glPosX", portalNode: portalNode, imageName: "posx")
    }
    
    /*
     Description:
        This function is used to load a plane with its texture
     Input:
     @ String nodeName: node name
     @ SCNNode portal Node: a scn node
     @ String imageName: image name
    */
    func addPlane(nodeName: String, portalNode: SCNNode, imageName: String) {
        let child = portalNode.childNode(withName: nodeName, recursively: true)
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(imageName).jpg")
        child?.renderingOrder = 200
    }
    
    /*
     Description:
        This function is used to load a wall with its texture
     Input:
        @ String nodeName: node name
        @ SCNNode portal Node: a scn node
        @ String imageName: image name
     */
    func addWall(nodeName: String, portalNode: SCNNode, imageName: String) {
        let child = portalNode.childNode(withName: nodeName, recursively: true)
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(imageName).jpg")
        child?.renderingOrder = 200
        if let mask = child?.childNode(withName: "mask", recursively: false) {
            mask.geometry?.firstMaterial?.transparency = 0.000001
        }
    }

}

