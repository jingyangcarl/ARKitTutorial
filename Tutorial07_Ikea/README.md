Tutorial 07 - Ikea
====================

## Tutorial 07 Result:
![Tutorial 07 Result](https://github.com/jingyangcarl/Resources/blob/master/ARKitTutorial/Tutorial07_Ikea/result.gif)

## Solution Introduction
This tutorial solution introduces GestureRecognizers, which is used to detect touch, pinch, long press events. In this application, after any horizontal plane detected, tapping on the plane will place a selected item on the plane. Then, pinch the object to conduct scale and long touch on the object to rotate the object;

## Solution Environment:
* MacOS Mojave 10.14.5
* Xcode 10.3

## Solution Documentation:
> ViewController.swift
>
>> **override func viewDidLoad():** This function is used to do initialization after the view is loaded;
>>
>> **func registerGestureRecognizers():** This function is used to register all gesture recognizers;
>>
>> **@objc func tapped(sender: UITapGestureRecognizer):** This function is an object-c function used as an action to detect tapping event;
>>
>> **@objc func pinch(sender: UIPinchGestureRecognizer):** This function is an object-c function used as an action to detect pinch event, which is used to scale the object;
>>
>> **@objc func rotate(sender: UILongPressGestureRecognizer):** This function is an object-c function used as an action to detect a long press event, which is used to rotate the object;
>>
>> **func centerPivot(for node: SCNNode):** This function is used to center the pivot, which is the center of rotation;
>>
>> **func addItem(hitTestResult: ARHitTestResult):** This function is used to add an item to scene view;
>>
>> **func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int:** This function is used to ask your data source ojbect for the number of items in the specified section, which indicates the number of cells;
>>
>> **func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell** This function is used to initialize cells in item collection view;
>>
>> **func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath):** This function is used to deal with cell selection event;
>>
>> **func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath):** This function is used to deal with cell deselection event
>>
>> **func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor):** This function is an interface from ARSCNViewDelegate, which is called whenever an ARAnchor is discovered, it adds a new ARAnchor to the scene
>

## Solution Hierarchy:
```
./Tutorial07_Ikea
├───Tutorial07_Ikea
│   ├───Assets.xcassets
│   │   └───AppIcon.appiconset
│   ├───Base.lproj
│   └───Models.scnassets
└───Tutorial07_Ikea.xcodeproj
    ├───project.xcworkspace
    │   ├───xcshareddata
    │   └───xcuserdata
    │       └───qingguoxu.xcuserdatad
    └───xcuserdata
        └───qingguoxu.xcuserdatad
            └───xcschemes
```
