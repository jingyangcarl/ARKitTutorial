Tutorial 02 - World Tracking
====================

## Tutorial 02 Result:
![Tutorial 02 Result](https://github.com/jingyangcarl/Resources/blob/master/ARKitTutorial/Tutorial02_WorldTracking/result.gif)

## Solution Introduction
This tutorial solution introduces a template to develop AR applications using Xcode with ARKit. When the button add is pushed, a house is drawn in this scene, which consists of a body, a roof, and a door. When the button reset is pushed, all nodes will be removed from the scene.

## Solution Environment:
* MacOS Mojave 10.14.5
* Xcode 10.3

## Solution Documentation:
> ViewController.swift
>
>> override func viewDidLoad(): This function is used to do initialization after the view is loaded;
>>
>> @IBAction func ButtonAdd(_ sender: Any): This function is the callback function of button Add, which is used to add a house node into the scene;
>>
>> @IBAction func ButtonReset(_ sender: Any): This function is the callback function of button Reset, which is used to remove all house nodes from the scene;
>

## Solution Hierarchy:
```
./Tutorial02_WorldTracking

```
