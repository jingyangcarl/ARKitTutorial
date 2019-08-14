Tutorial 05 - Whack A Jellyfish
====================

## Tutorial 05 Result:
![Tutorial 05 Result](https://github.com/jingyangcarl/Resources/blob/master/ARKitTutorial/Tutorial05_WhackAJellyfish/result.gif)

## Solution Introduction:
This tutorial solution introduces tap-on detection using gesture recognizer, and how to use Cocoapods to manage packages (a timer framework in this case). The application implements a game that after clicking on the play button, jellyfish will popup somewhere in the AR scene. Look for the jellyfish and click on it will trigger the next jellyfish until the timer runs out.

## Solution Environment:
* MacOS Mojave 10.14.5
* Xcode 10.3
* Cocoapods 1.7.5
* [Each 1.2](https://github.com/dalu93/Each)

## Solution Documentation:
> ViewController.swift
>
>> **override func viewDidLoad():** This function is used to do initialization after the view is loaded;
>>
>> **@objc func handleTap(sender: UITapGestureRecognizer):** This function is used to handle tap events;
>>
>> **@IBAction func ButtonPlay(_ sender: Any):** This function is the callback function of button Play, which is used to trigger the timer and generate jellyfish;
>>
>> **@IBAction func ButtonReset(_ sender: Any):** This function is the callback function of button Reset, which is used to remove all jellyfish nodes from the scene and reset the timer;
>>
>> **func addNode():** This function is used to add a node to the sceneView;
>>
>> **func animateNode(node: SCNNode):** This function is used to generate animation for a given node;
>>
>> **func RandomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat:** This function is used to generate a random number from a given range;
>>
>> **func SetTimer():** This function is used to set a timer;
>>
>> **func RestoreTiemr():** This function is used to reset the timer;
>

## Solution Hierarchy:
```
./Tutorial05_WhackAJellyfish
├───Pods
│   ├───Each
│   │   └───Sources
│   ├───Pods.xcodeproj
│   │   └───xcuserdata
│   │       └───qingguoxu.xcuserdatad
│   │           └───xcschemes
│   └───Target Support Files
│       ├───Each
│       └───Pods-Tutorial05_WhackAJellyfish
├───Tutorial05_WhackAJellyfish
│   ├───art.scnassets
│   ├───Assets.xcassets
│   │   ├───AppIcon.appiconset
│   │   ├───Play.imageset
│   │   └───Reset.imageset
│   └───Base.lproj
├───Tutorial05_WhackAJellyfish.xcodeproj
│   ├───project.xcworkspace
│   │   ├───xcshareddata
│   │   └───xcuserdata
│   │       └───qingguoxu.xcuserdatad
│   └───xcuserdata
│       └───qingguoxu.xcuserdatad
│           └───xcschemes
└───Tutorial05_WhackAJellyfish.xcworkspace
    ├───xcshareddata
    └───xcuserdata
        └───qingguoxu.xcuserdatad
```
