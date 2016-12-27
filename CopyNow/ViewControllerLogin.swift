//
//  ViewController.swift
//  CopyNow
//
//  Created by 함의진 on 2016. 12. 24..
//  Copyright © 2016년 함의진. All rights reserved.
//

import UIKit
import Toaster

class ViewControllerLogin: UIViewController{
    
    var indicator:ProgressIndicator?
    
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
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Loading...")
        self.view.addSubview(indicator!)
    }
    
    func userAuth(account:String?){
        if(account?.isEmpty)!{
            return
        }
        indicator!.start()
        let urlString = "http://yjham2002.woobi.co.kr/copynow/host.php?tr=108&id="
        
        var res:Int? = 0
        
        let url = URL(string: urlString + (account ?? ""))
        let task = URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error ?? "None")
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    res = parsedData as? Int
                } catch let error as NSError {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.indicator!.stop()
                if(res == 0){
                    Toast(text: "invalid ID").show()
                }
                else{
                    self.performSegue(withIdentifier: "signin", sender: nil)
                }
                
                
            }
        }
        task.resume()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        if !(accountText.text?.isEmpty ?? false){
            userAuth(account: accountText.text)
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        print("Sign Up Tabbed")
    }
    
}
