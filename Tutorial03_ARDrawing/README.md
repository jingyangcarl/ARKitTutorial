Tutorial 03 - AR Drawing
====================

## Tutorial 03 Result:
![Tutorial 03 Result](https://github.com/jingyangcarl/Resources/blob/master/ARKitTutorial/Tutorial03_ARDrawing/result.gif)

## Solution Introduction
This tutorial solution introduces how to draw a 3D geometry using ARKit with knowledge of view matrix. In the application, if the button is pushed, spheres will be continuously placed at where the camera is. If the button is not pushed, a sphere in another color will be placed and than removed.

## Solution Environment:
* MacOS Mojave 10.14.5
* Xcode 10.3

## Solution Documentation:
> ViewController.swift
>
>> func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval): This function is used to tell the delegate that the renderer has cleared the viewport and is about to render to scene. In this case, if the button is pushed, spheres will be continuously placed at where the camera is, if the button is not pushed, a sphere (marker) will be placed at where the camera and then removed.
>

## Solution Hierarchy:
```
./Tutorial03_ARDrawing

```
