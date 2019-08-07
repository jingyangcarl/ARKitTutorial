//
//  ViewController.swift
//  Tutorial04_Planets
//
//  Created by qingguo xu on 8/7/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        // The only way to make specular works is turning on the light
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        // generate the center of solar system
        let sunNode = SCNNode()
        sunNode.geometry = SCNSphere(radius: 0.5)
        sunNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun Diffuse")
        sunNode.position = SCNVector3(0.0, 0.0, -1.0)
        self.sceneView.scene.rootNode.addChildNode(sunNode)
        
        // generate other nodes in the solar system
        let mercuryParent = SCNNode()
        let venusParent = SCNNode()
        let earthParent = SCNNode()
        let moonParent = SCNNode()
        let marsParent = SCNNode()
        let jupiterParent = SCNNode()
        let saturnParent = SCNNode()
        let uranusParent = SCNNode()
        let neptuneParent = SCNNode()
        
        // planet radius ratio
        // the data can be found on the following webpage:
        // https://nssdc.gsfc.nasa.gov/planetary/factsheet/planet_table_ratio.html
        let normalRadius = 0.1
        let mercuryRadius = 0.383 * normalRadius
        let venusRadius = 0.949 * normalRadius
        let earthRadius = 1.0 * normalRadius
        let moonRadius = 0.2724 * normalRadius
        let marsRadius = 0.532 * normalRadius
        let jupiterRadius = 11.21 * normalRadius
        let saturnRadius = 9.45 * normalRadius
        let uranusRadius = 4.01 * normalRadius
        let neptuneRadius = 3.88 * normalRadius
        
        // planet distance ratio from sun
        // the data can be found on the following webpage:
        // https://nssdc.gsfc.nasa.gov/planetary/factsheet/planet_table_ratio.html
        let normalDistance = 2.0
        let mercuryDistance = 0.387 * normalDistance
        let venusDistance = 0.723 * normalDistance
        let earthDistance = 1.0 * normalDistance
        let moonDistance = 0.00257 * normalDistance * 40
        let marsDistance = 1.52 * normalDistance
        let jupiterDistance = 5.20 * normalDistance
        let saturnDistance = 9.58 * normalDistance
        let uranusDistance = 19.20 * normalDistance
        let neptuneDistance = 30.30 * normalDistance
        
        // generate planets with textures
        let mercuryNode = createPlanet(geometry: SCNSphere(radius: CGFloat(mercuryRadius)), diffuse: #imageLiteral(resourceName: "Mercury Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(mercuryDistance, 0.0, 0.0))
        let venusNode = createPlanet(geometry: SCNSphere(radius: CGFloat(venusRadius)), diffuse: #imageLiteral(resourceName: "Venus Diffuse"), specular: nil, emission: #imageLiteral(resourceName: "Venus Emission"), normal: nil, position: SCNVector3(venusDistance, 0.0, 0.0))
        let earthNode = createPlanet(geometry: SCNSphere(radius: CGFloat(earthRadius)), diffuse: #imageLiteral(resourceName: "Earth Diffuse"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(earthDistance, 0.0, 0.0))
        let moonNode = createPlanet(geometry: SCNSphere(radius: CGFloat(moonRadius)), diffuse: #imageLiteral(resourceName: "Moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(moonDistance, 0.0, 0.0))
        let marsNode = createPlanet(geometry: SCNSphere(radius: CGFloat(marsRadius)), diffuse: #imageLiteral(resourceName: "Mars Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(marsDistance, 0.0, 0.0))
        let jupiterNode = createPlanet(geometry: SCNSphere(radius: CGFloat(jupiterRadius)), diffuse: #imageLiteral(resourceName: "Jupiter Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(jupiterDistance, 0.0, 0.0))
        let saturnNode = createPlanet(geometry: SCNSphere(radius: CGFloat(saturnRadius)), diffuse: #imageLiteral(resourceName: "Saturn Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(saturnDistance, 0.0, 0.0))
        let uranusNode = createPlanet(geometry: SCNSphere(radius: CGFloat(uranusRadius)), diffuse: #imageLiteral(resourceName: "Uranus Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(uranusDistance, 0.0, 0.0))
        let neptuneNode = createPlanet(geometry: SCNSphere(radius: CGFloat(neptuneRadius)), diffuse: #imageLiteral(resourceName: "Neptune Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(neptuneDistance, 0.0, 0.0))
    
        // set position
        mercuryParent.position = sunNode.position
        venusParent.position = sunNode.position
        earthParent.position = sunNode.position
        moonParent.position = earthNode.position
        marsParent.position = sunNode.position
        jupiterParent.position = sunNode.position
        saturnParent.position = sunNode.position
        uranusParent.position = sunNode.position
        neptuneParent.position = sunNode.position
        
        // add nodes based on the hierarchy
        self.sceneView.scene.rootNode.addChildNode(mercuryParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        earthParent.addChildNode(moonParent)
        self.sceneView.scene.rootNode.addChildNode(marsParent)
        self.sceneView.scene.rootNode.addChildNode(jupiterParent)
        self.sceneView.scene.rootNode.addChildNode(saturnParent)
        self.sceneView.scene.rootNode.addChildNode(uranusParent)
        self.sceneView.scene.rootNode.addChildNode(neptuneParent)
        
        mercuryParent.addChildNode(mercuryNode)
        venusParent.addChildNode(venusNode)
        earthParent.addChildNode(earthNode)
        moonParent.addChildNode(moonNode)
        marsParent.addChildNode(marsNode)
        jupiterParent.addChildNode(jupiterNode)
        saturnParent.addChildNode(saturnNode)
        uranusParent.addChildNode(uranusNode)
        neptuneParent.addChildNode(neptuneNode)
        
        // planet revolution around the sun
        // the data can be found on the following webpage:
        // https://nssdc.gsfc.nasa.gov/planetary/factsheet/planet_table_ratio.html
        let normalRevolutionTime = 8.0
        let mercuryRevolutionTime = 0.241 * normalRevolutionTime
        let venusRevolutionTime = 0.615 * normalRevolutionTime
        let earthRevolutionTime = 1.0 * normalRevolutionTime
        let moonRevolutionTime = 0.0748 * normalRevolutionTime
        let marsRevolutionTime = 1.88 * normalRevolutionTime
        let jupiterRevolutionTime = 11.9 * normalRevolutionTime
        let saturnRevolutionTime = 29.4 * normalRevolutionTime
        let uranusRevolutionTime = 83.8 * normalRevolutionTime
        let neptuneRevolutionTime = 163.7 * normalRevolutionTime
        
        let mercuryRevolution = planetRotation(time: mercuryRevolutionTime)
        let venusRevolution = planetRotation(time: venusRevolutionTime)
        let earthRevolution = planetRotation(time: earthRevolutionTime)
        let moonRevolution = planetRotation(time: moonRevolutionTime)
        let marsRevolution = planetRotation(time: marsRevolutionTime)
        let jupiterRevolution = planetRotation(time: jupiterRevolutionTime)
        let saturnRevolution = planetRotation(time: saturnRevolutionTime)
        let uranusRevolution = planetRotation(time: uranusRevolutionTime)
        let neptuneRevolution = planetRotation(time: neptuneRevolutionTime)
        
        mercuryParent.runAction(mercuryRevolution)
        venusParent.runAction(venusRevolution)
        earthParent.runAction(earthRevolution)
        moonParent.runAction(moonRevolution)
        marsParent.runAction(marsRevolution)
        jupiterParent.runAction(jupiterRevolution)
        saturnParent.runAction(saturnRevolution)
        uranusParent.runAction(uranusRevolution)
        neptuneParent.runAction(neptuneRevolution)
        
        // planet rotation
        // the data can be found on the following webpage:
        // https://nssdc.gsfc.nasa.gov/planetary/factsheet/planet_table_ratio.html
        let normalRotationTime = 2.0;
        let sunRotationTime = 0.066 * normalRotationTime * 50
        let mercuryRotationTime = 175.9 * normalRotationTime
        let venusRotationTime = 116.8 * normalRevolutionTime
        let earthRotationTime = 1.0 * normalRevolutionTime
        let moonRotationTime = 27.4 * normalRevolutionTime
        let marsRotationTime = 1.03 * normalRevolutionTime
        let jupiterRotationTime = 0.414 * normalRevolutionTime
        let saturnRotationTime = 0.444 * normalRevolutionTime
        let uranusRotationTime = 0.718 * normalRevolutionTime
        let neptuneRotationTime = 0.671 * normalRevolutionTime
        
        let sunRotation = planetRotation(time: sunRotationTime)
        let mercuryRotation = planetRotation(time: mercuryRotationTime)
        let venusRotation = planetRotation(time: venusRotationTime)
        let earthRotation = planetRotation(time: earthRotationTime)
        let moonRotation = planetRotation(time: moonRotationTime)
        let marsRotation = planetRotation(time: marsRotationTime)
        let jupiterRotation = planetRotation(time: jupiterRotationTime)
        let saturnRotation = planetRotation(time: saturnRotationTime)
        let uranusRotation = planetRotation(time: uranusRotationTime)
        let neptuneRotation = planetRotation(time: neptuneRotationTime)
        
        sunNode.runAction(sunRotation)
        mercuryNode.runAction(mercuryRotation)
        venusNode.runAction(venusRotation)
        earthNode.runAction(earthRotation)
        moonNode.runAction(moonRotation)
        marsNode.runAction(marsRotation)
        jupiterNode.runAction(jupiterRotation)
        saturnNode.runAction(saturnRotation)
        uranusNode.runAction(uranusRotation)
        neptuneNode.runAction(neptuneRotation)
        
    }
    
    /*
     Description:
        This function is used to generate a SCNNode with textures which represents a planet
     Input:
        @ SCNGeometry geometry: planet geometry, sphere or others
        @ UIImage diffuse: diffuse map
        @ UIImage? specular: specular map (optional)
        @ UIImage? emission: emission map (optional)
        @ UIImage? normal: normal map (optional)
        @ SCNVector3 position: planet init position
     Output:
        @ SCNNode returnValue: a planet node
    */
    func createPlanet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        // The texture is downloaded from the following link:
        // https://www.solarsystemscope.com/textures
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    /*
     Description:
        This function is used to generate a rotation action
     Input:
        @ TimeInterval time: how long does the object needs to finish the rotation
     Output:
        @ SCNAction returnValue: a rotation action
    */
    func planetRotation(time: TimeInterval) -> SCNAction {
        let rotation = SCNAction.rotateBy(x: 0.0, y: CGFloat(360.degreesToRadians), z: 0.0, duration: time)
        let rotationForever = SCNAction.repeatForever(rotation)
        return rotationForever
    }
}

extension Int{
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
