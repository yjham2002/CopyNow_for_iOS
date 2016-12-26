//
//  ViewController.swift
//  CopyNow
//
//  Created by 함의진 on 2016. 12. 24..
//  Copyright © 2016년 함의진. All rights reserved.
//

import UIKit

class ViewController3: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let alert = UIAlertController(title: "Logout", message: "Do you really want to logout?", preferredStyle: UIAlertControllerStyle.actionSheet)
    let alertOk = UIAlertAction(title: "Logout", style: UIAlertActionStyle.default, handler: nil)
    let alertNo = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
    
    let menus = ["App Information","Go to Website","Sign out"]
    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alert.addAction(alertOk)
        alert.addAction(alertNo)
        
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
            case 0: break
            case 1:
                let url = URL(string: "http://www.copynow.kr")!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            case 2: present(alert, animated: true, completion: nil)
            default: break
        }

    }
    
}
