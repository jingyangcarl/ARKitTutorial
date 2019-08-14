Tutorial 06 - Floors Is Lava
====================

## Tutorial 06 Result:
![Tutorial 06 Result](https://github.com/jingyangcarl/Resources/blob/master/ARKitTutorial/Tutorial06_FloorIsLava/result.gif)

## Solution Introduction
This tutorial solution introduces plane detection, and tell the difference between didAdd, didUpdate, didRemove renderers. The application will add lava nodes to where the horizontal plane is detected;

## Solution Environment:
* MacOS Mojave 10.14.5
* Xcode 10.3

## Solution Documentation:
> ViewController.swift
>
>> **override func viewDidLoad():** This function is used to do initialization after the view is loaded;
>>
>> **func createLavaNode(planeAnchor: ARPlaneAnchor) -> SCNNode:** This function is used to generate a lava node based on where the plane is detected;
>>
>> **func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor):** This function is an interface from ARSCNViewDelegate, which is called whenever an ARAnchor is discovered, it adds a new ARAnchor to the scene;
>>
>> **func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor):** This function is an interface from ARSCNViewDelegate, which is called whenever the device discovers more of the same horizontal surface, it updates the AR anchor;
>>
>> **func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor):** This function is an interface from ARSCNViewDelegate, which is called whenever the device adds more than one plane anchor for the same horizontal surface, it removes it.
>

## Solution Hierarchy:
```
./Tutorial06_FloorIsLava
```
