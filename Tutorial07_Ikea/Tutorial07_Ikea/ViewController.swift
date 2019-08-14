//
//  ViewController.swift
//  Tutorial07_Ikea
//
//  Created by Jing Yang on 8/9/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    let configuration = ARWorldTrackingConfiguration()
    
    @IBOutlet weak var labelPlaneDetected: UILabel!
    let itemsArray: [String] = ["cup", "vase", "boxing", "table"]
    var selectedItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.itemsCollectionView.dataSource = self
        self.itemsCollectionView.delegate = self
        self.sceneView.delegate = self
        self.registerGestureRecognizers()
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }
    
    /*
     Description:
        This function is used to register all gesture recognizers
     Input:
        @ nil parameter: nil
     Output:
        @ nil returnValue: nil
    */
    func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(rotate))
        longPressGestureRecognizer.minimumPressDuration = 0.1
        self.sceneView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    /*
     Description:
        This function is an object-c function used as an action to detect tapping event
     Input:
        @ UITapGesturerecognizer sender: a tap gesture recognizer
     Output:
        @ nil returnValue: nil
    */
    @objc func tapped(sender: UITapGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        if !hitTest.isEmpty {
            self.addItem(hitTestResult: hitTest.first!)
        } else {
            
        }
    }
    
    /*
     Description:
        This function is an object-c function used as an action to detect pinch event, which is used to scale the object
     Input:
        @ UIPinchGestureRecognizer sender: a pinch gesture recognizer
     Output:
        @ nil returnValue: nil
    */
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let pinchLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(pinchLocation)
        if !hitTest.isEmpty {
            let result = hitTest.first!
            let node = result.node
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            node.runAction(pinchAction)
            // reset the scale, which maintains the scale as a constant
            sender.scale = 1.0
        }
    }
    
    /*
     Description:
        This function is an object-c function used as an action to detect a long press event, which is used to rotate the object
     Input:
        @ UILongPressGestureRecognizer sender: a long press gesture recognizer
     Output:
        @ nil returnValue: nil
    */
    @objc func rotate(sender: UILongPressGestureRecognizer) {
        
        let sceneView = sender.view as! ARSCNView
        let holdLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(holdLocation)
        if !hitTest.isEmpty {
            let result = hitTest.first!
            if sender.state == .began {
                let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 1)
                let forever = SCNAction.repeatForever(rotation)
                result.node.runAction(forever)
            } else if sender.state == .ended {
                result.node.removeAllActions()
            }
        }
    }
    
    /*
     Description:
        This function is used to center the pivot, which is the center of rotation
     Input:
        @ SCNNode for node: a SCNNode need to be centralized
     Output:
        @ nil returnValue: nil
    */
    func centerPivot(for node: SCNNode) {
        let min = node.boundingBox.min
        let max = node.boundingBox.max
        node.pivot = SCNMatrix4MakeTranslation(
            min.x + (max.x - min.x) / 2,
            min.y + (max.y - min.y) / 2,
            min.z + (max.z - min.z) / 2)
    }
    
    /*
     Description:
        This function is used to add an item to scene view
     Input:
        @ ARHitTestResult hitTestResult: a hit test result
     Output:
        @ nil returnValue: nil
    */
    func addItem(hitTestResult: ARHitTestResult) {
        if let selectedItem = self.selectedItem {
            let scene = SCNScene(named: "Models.scnassets/\(selectedItem).scn")
            let node = (scene?.rootNode.childNode(withName: selectedItem, recursively: false))!
            let transform = hitTestResult.worldTransform
            let thirdColumn = transform.columns.3
            node.position = SCNVector3(thirdColumn.x, thirdColumn.y, thirdColumn.z)
            self.centerPivot(for: node)
            self.sceneView.scene.rootNode.addChildNode(node)
        }
    }

    /*
     Description:
        This function is used to ask your data source ojbect for the number of items in the specified section, which indicates the number of cells
     Input:
     @ UICollectionView _ collectionView: the collection view
     @ Int numberOfItemsInSection section: the number of itmes in section
     Output:
        @ Int returnValue: the number of cells CollectionView will display
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    /*
     Description:
        This function is used to initialize cells in item collection view
     Input:
        @ UICollectionView _ collectionView: the collection view
        @ IndexPath cellForItemAt indexPath: indexPath
     Output:
        @ UICollectionViewCell returnValue: a cell
    */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! itemCell // downcast
        cell.itemLabel.text = self.itemsArray[indexPath.row]
        return cell
    }
    
    /*
     Description:
        This function is used to deal with cell selection event
     Input:
        @ UICollectionView _ collectionView: the collection view
        @ IndexPath didSelectItemAt indexPath: indexPath
     Output:
        @ nil returnValue: nil
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.selectedItem = itemsArray[indexPath.row]
        cell?.backgroundColor = UIColor.green
    }
    
    /*
     Description:
        This function is used to deal with cell deselection event
     Input:
        @ UICollectionView _ collectionView: the collection view
        @ IndexPath didSelectItemAt indexPath: indexPath
     Output:
        @ nil returnValue: nil
     */
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.blue
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
        guard anchor is ARPlaneAnchor else {
            return
        }
        DispatchQueue.main.async {
            self.labelPlaneDetected.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.labelPlaneDetected.isHidden = true
            }
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
