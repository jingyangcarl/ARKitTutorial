Tutorial 09 - AR Measuring
====================

## Tutorial 09 Result:
![Tutorial 09 Result](https://github.com/jingyangcarl/Resources/blob/master/ARKitTutorial/Tutorial09_ARMeasuring/result.gif)

## Solution Introduction
This tutorial solution introduces another way to use view matrix and build up a AR measuring app.

## Solution Environment:
* MacOS Mojave 10.14.5
* Xcode 10.3

## Solution Documentation:
> ViewController.swift
>
>> **override func viewDidLoad():** This function is used to do initialization after the view is loaded;
>>
>> **@objc func handleTap(sender: UITapGestureRecognizer):** This function is used to handle tap events;
>>
>> **func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval):** This function is used to update distance labels;
>>
>> **func distanceTravelled(x:Float, y:Float, z:Float) -> Float:** This function is used to calculate distance;

## Solution Hierarchy:
```
./Tutorial09_ARMeasuring
├───Tutorial09_ARMeasuring
│   ├───Assets.xcassets
│   │   ├───Add.imageset
│   │   └───AppIcon.appiconset
│   └───Base.lproj
└───Tutorial09_ARMeasuring.xcodeproj
    ├───project.xcworkspace
    │   ├───xcshareddata
    │   └───xcuserdata
    │       └───qingguoxu.xcuserdatad
    └───xcuserdata
        └───qingguoxu.xcuserdatad
            └───xcschemes
```
