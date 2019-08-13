//
//  ViewController.swift
//  Tutorial01_Counter
//
//  Created by Jing Yang on 8/6/19.
//  Copyright © 2019 Jing Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var number: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func perform(_ sender: Any) {
        self.number += 1
        self.label.text = String(number)
    }
    
}

