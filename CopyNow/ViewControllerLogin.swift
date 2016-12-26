//
//  ViewController.swift
//  CopyNow
//
//  Created by 함의진 on 2016. 12. 24..
//  Copyright © 2016년 함의진. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController{
    
    @IBOutlet weak var accountText: UITextField!
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "signin"){
            let tabBarController = segue.destination as! UITabBarController;
            let dest = tabBarController.viewControllers![2] as! ViewController3
            dest.account = accountText.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login View")
        self.hideKeyboardWhenTappedAround() 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSignIn(_ sender: Any) {
        print("Sign In Tabbed")
    }
    @IBAction func onSignUp(_ sender: Any) {
        print("Sign Up Tabbed")
    }
    
}
