//
//  ViewController.swift
//  CopyNow
//
//  Created by 함의진 on 2016. 12. 24..
//  Copyright © 2016년 함의진. All rights reserved.
//

import UIKit

class ViewControllerSign: UIViewController{
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Signup View")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
}
