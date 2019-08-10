//
//  ViewController.swift
//  Tutorial07_Ikea
//
//  Created by Jing Yang on 8/9/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    let configuration = ARWorldTrackingConfiguration()
    
    let itemsArray: [String] = ["cup", "vase", "boxing", "table"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.itemsCollectionView.dataSource = self
        self.itemsCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }

    /*
     Description:
     Input:
     Output:
     @ Int returnValue: the number of cells CollectionView will display
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    // congifures every cells in collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! itemCell // downcast
        cell.itemLabel.text = self.itemsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.green
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.blue
    }
}

