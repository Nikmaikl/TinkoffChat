//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 20.09.17.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("\(#function) was processed")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("\(#function) was processed")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("\(#function) was processed")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("\(#function) was processed")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("\(#function) was processed")
    }
}

