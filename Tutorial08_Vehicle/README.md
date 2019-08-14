Tutorial 08 - Vehicle
====================

## Tutorial 08 Result:
![Tutorial 08 Result](https://github.com/jingyangcarl/Resources/blob/master/ARKitTutorial/Tutorial08_Vehicle/result.gif)

## Solution Introduction:
This tutorial solution introduces accelerometer and graphics body to create a vehicle AR application, one finger touch accelerates the vehicle, two finger touch reverses the vehicle, three finger touch brakes the vehicle.

## Solution Documentation:
> ViewController.swift
>
>> **override func viewDidLoad():** This function is used to do initialization after the view is loaded;
>>
>> **func createConcreteNode(planeAnchor: ARPlaneAnchor) -> SCNNode:** This function is used to add concrete node, which is a static physics body;
>>
>> **@IBAction func addCar(_ sender: Any):** This function is the callback function of button Add, which is used to add a car node into the scene;
>>
>> **func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor):** This function is an interface from ARSCNViewDelegate, which is called whenever an ARAnchor is discovered, it adds a new ARAnchor to the scene;
>>
>> **func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor):** This function is an interface from ARSCNViewDelegate, which is called whenever the device discovers more of the same horizontal surface, it updates the AR anchor;
>>
>> **func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor):** This function is an interface from ARSCNViewDelegate, which is called whenever the device adds more than one plane anchor for the same horizontal surface, it removes it;
>>
>> **func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval):** This function is an interface from ARSCNViewDelegate, which is to tell the delegate to perform any upates that need to occur after physics simulations are performed;
>>
>> **func setupAccelerometer():** This function is used to setup the accelerometer
>>
>> **func accelerometerDidChange(acceleration: CMAcceleration):** This function is used to detect any change of accelerometer;
>>
>> **override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?):** This function is used to deal with touches began;
>>
>> **override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?):** This function is used to deal with touches ended
>

## Solution Environment:
* MacOS Mojave 10.14.5
* Xcode 10.3

## Solution Hierarchy:
```
./Tutorial08_Vehicle

```
