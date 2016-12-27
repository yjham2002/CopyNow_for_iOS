//
//  ViewController.swift
//  CopyNow
//
//  Created by 함의진 on 2016. 12. 24..
//  Copyright © 2016년 함의진. All rights reserved.
//

import UIKit

class ViewController3: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var accountLabel: UILabel!
    
    var account:String? = "Account Info"
    
    let menus = ["Go to Website","Sign out"]
    
    let alert = UIAlertController(title: "Sign Out", message: "Do you really want to sign out?", preferredStyle: UIAlertControllerStyle.actionSheet)
    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        accountLabel.text = account
        
        alert.addAction(UIAlertAction(title: "Sign out", style: .default, handler: {action in
            self.performSegue(withIdentifier: "logout", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        myTable.delegate = self;
        myTable.dataSource = self;
        myTable.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setCell", for: indexPath as IndexPath) as! setCell
        
        cell.menuLabel.text = menus[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row){
            case 0:
                let url = URL(string: "http://yjham2002.woobi.co.kr/copynow/content.php?id=" + (account ?? ""))!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            case 1: present(alert, animated: true, completion: nil)
            default: break
        }

    }
    
}
