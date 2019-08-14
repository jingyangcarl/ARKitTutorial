Tutorial 04 - Planets
====================

## Tutorial 04 Result:
![Tutorial 04 Result](https://github.com/jingyangcarl/Resources/blob/master/ARKitTutorial/Tutorial04_Planets/result.gif)

## Solution Introduction
This tutorial solution introduces how to use texture on a spherical object, and how to set the rotation action on a given object. A simple solar system is created.

## Solution Environment:
* MacOS Mojave 10.14.5
* Xcode 10.3

## Solution Documentation:
> ViewController.swift
>
>> **override func viewDidLoad():** This function is used to do initialization after the view is loaded;
>>
>> **override func viewDidAppear(_ animated: Bool):** This function notifies the view controller that its view was added to a view hierarchy. In this case, the function is used to do solar system initialization after the view is appear;
>>
>> **func createPlanet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode:** This function is used to generate a SCNNode with textures which represents a planet;
>>
>> **func planetRotation(time: TimeInterval) -> SCNAction:** This function is used to generate a rotation action;
>

## Solution Hierarchy:
```
./Tutorial04_Planets
├───Tutorial04_Planets
│   ├───Assets.xcassets
│   │   ├───AppIcon.appiconset
│   │   ├───Earth Diffuse.imageset
│   │   ├───Earth Emission.imageset
│   │   ├───Earth Normal.imageset
│   │   ├───Earth Specular.imageset
│   │   ├───Jupiter Diffuse.imageset
│   │   ├───Mars Diffuse.imageset
│   │   ├───Mercury Diffuse.imageset
│   │   ├───Moon Diffuse.imageset
│   │   ├───Neptune Diffuse.imageset
│   │   ├───Saturn Diffuse.imageset
│   │   ├───Saturn Ring Diffuse.imageset
│   │   ├───Sun Diffuse.imageset
│   │   ├───Uranus Diffuse.imageset
│   │   ├───Venus Diffuse.imageset
│   │   └───Venus Emission.imageset
│   └───Base.lproj
└───Tutorial04_Planets.xcodeproj
    ├───project.xcworkspace
    │   ├───xcshareddata
    │   └───xcuserdata
    │       └───qingguoxu.xcuserdatad
    └───xcuserdata
        └───qingguoxu.xcuserdatad
            └───xcschemes
```
