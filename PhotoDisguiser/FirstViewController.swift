//
//  ViewController.swift
//  PhotoDisguiser
//
//  Created by Kyoya Yamaguchi on 2017/01/19.
//  Copyright © 2017年 Kyoya Yamaguchi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

