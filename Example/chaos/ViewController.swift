//
//  ViewController.swift
//  chaos
//
//  Created by woodjobber on 06/12/2021.
//  Copyright (c) 2021 woodjobber. All rights reserved.
//

import UIKit
import chaos
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       let isMatching = Chaos.match(needle: "after", haystack: "Do any additional setup after loading the view, typically from a nib.")
        if isMatching {
            print("matching")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

