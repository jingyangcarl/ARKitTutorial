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
    
    @IBAction func perform(_ sender: Any) {
        
//        // the following code is the if-else statement in swift
//        if let number = self.label.text {
//            print(number)
//        } else {
//            print("value is null")
//        }
        
//        // the following code the same as if else statement
//         guard let number = self.label.text else {return}
//         print(number)
        
        self.number += 1
        self.label.text = String(number)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

