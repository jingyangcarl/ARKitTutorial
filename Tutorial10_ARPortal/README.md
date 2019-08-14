Tutorial 10 - AR Portal
====================

## Tutorial 10 Result:
![Tutorial 10 Result](https://github.com/jingyangcarl/Resources/blob/master/ARKitTutorial/Tutorial10_ARPortal/result.gif)

## Solution Introduction
This tutorial solution introduces how to set up a cube map with masks in AR environment

## Solution Environment:
* MacOS Mojave 10.14.5
* Xcode 10.3

## Solution Documentation:
> ViewController.swift
>
>> **override func viewDidLoad():** This function is used to do initialization after the view is loaded;
>>
>> **func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor):** This function is an interface from ARSCNViewDelegate, which is called whenever an ARAnchor is discovered, it adds a new ARAnchor to the scene;
>>
>> **@objc func handleTap(sender: UITapGestureRecognizer):** This function is used to handle tap events;
>>
>> **func addPortal(hitTestResult: ARHitTestResult):** This function is used to load scene and load skybox;
>> **func addPlane(nodeName: String, portalNode: SCNNode, imageName: String):** This function is used to load a plane with its texture;
>>
>> **func addWall(nodeName: String, portalNode: SCNNode, imageName: String):** This function is used to load a wall with its texture
>

## Solution Hierarchy:
```
./Tutorial10_ARPortal

```
