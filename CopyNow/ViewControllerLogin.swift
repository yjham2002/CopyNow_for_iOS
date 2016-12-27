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
            let dest1 = tabBarController.viewControllers![0] as! ViewController
            let dest2 = tabBarController.viewControllers![2] as! ViewController3
            dest1.account = accountText.text
            dest2.account = accountText.text
            accountText.text = ""
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login View")
        self.hideKeyboardWhenTappedAround() 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        if !(accountText.text?.isEmpty ?? false){
            performSegue(withIdentifier: "signin", sender: nil)
        }else{
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        print("Sign Up Tabbed")
    }
    
}
