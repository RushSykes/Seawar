//
//  RuleViewController.swift
//  SeaWar
//
//  Created by Rush Sykes on 21/05/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import UIKit

class RuleViewController: UIViewController {
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

