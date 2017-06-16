//
//  ViewController.swift
//  SafeDispatch
//
//  Created by PF on 17/2/13.
//  Copyright © 2017年 PF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SafeDispatch.async { 
            print("task \(Thread.current)")
        }
        
        DispatchQueue.main.safeAsync { 
            print("task \(Thread.current)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

