//
//  ViewController.swift
//  Example
//
//  Created by Nguyễn Trung on 9/22/20.
//  Copyright © 2020 Nguyễn Trung. All rights reserved.
//

import UIKit
import EasyLoginTalkManager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapButton(_ sender: Any) {
          EasyLoginTalkManager.share.login(key: "a123456987", currentViewController: self, animation: true)
    }
    
}
