Tutorial 11 - AR Hoops
====================

## Tutorial 11 Result:
![Tutorial 11 Result](https://github.com/jingyangcarl/Resources/blob/master/ARKitTutorial/Tutorial11_ARHoops/result.gif)

## Solution Introduction
This tutorial solution is a combination of the previous tutorials, which builds up a basketball shooting game.

## Solution Environment:
* MacOS Mojave 10.14.5
* Xcode 10.3

## Solution Documentation:
> ViewController.swift
>
>> **override func viewDidLoad():** This function is used to do initialziation after the view is loaded;
>>
>> **func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor):** This function is an interface from ARSCNViewDelegate, which is called whenever an ARAnchor is discovered, it adds a new ARAnchor to the scene;
>>
>> **@objc func handleTap(sender: UITapGestureRecognizer):** This function is used to handle tap events;
>>
>> **func addBasket(hitTestResult: ARHitTestResult):** This function is used to load scene and display the basket;
>>
>> **override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?):** This function is used to deal with touches began, which is used to control the power of ball shooting;
>>
>> **override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)** This function is used to deal with touches ended, which is used to reset the power of ball shooting;
>>
>> **func shootBall():** This function is used to control how to shoot the ball;
>>
>> **func removeEveryOtherBall():** This function is used to remove all the balls from current scene;
>

## Solution Hierarchy:
```
./Tutorial11_ARHoops
├───Pods
│   ├───Each
│   │   └───Sources
│   ├───Pods.xcodeproj
│   │   └───xcuserdata
│   │       └───qingguoxu.xcuserdatad
│   │           └───xcschemes
│   └───Target Support Files
│       ├───Each
│       └───Pods-Tutorial11_ARHoops
├───Tutorial11_ARHoops
│   ├───Assets.xcassets
│   │   ├───AppIcon.appiconset
│   │   ├───Ball.imageset
│   │   └───Plus.imageset
│   ├───Base.lproj
│   └───Basketball.scnassets
├───Tutorial11_ARHoops.xcodeproj
│   ├───project.xcworkspace
│   │   ├───xcshareddata
│   │   └───xcuserdata
│   │       └───qingguoxu.xcuserdatad
│   └───xcuserdata
│       └───qingguoxu.xcuserdatad
│           └───xcschemes
└───Tutorial11_ARHoops.xcworkspace
    ├───xcshareddata
    └───xcuserdata
        └───qingguoxu.xcuserdatad
```
