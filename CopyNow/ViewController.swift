//
//  ViewController.swift
//  CopyNow
//
//  Created by 함의진 on 2016. 12. 24..
//  Copyright © 2016년 함의진. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let alert = UIAlertController(title: "Copy", message: "Do you really want to copy this contents?", preferredStyle: UIAlertControllerStyle.actionSheet)
    let alertOk = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil)
    let alertNo = UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil)
    
    let dates = ["2014","2015","2016"]
    let cnts = ["swift swift swift swift swift swift swift swift swift swift swift","iOS","Testing"]
    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.delegate = self;
        myTable.dataSource = self;
        
        alert.addAction(alertOk)
        alert.addAction(alertNo)
        
        myTable.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath as IndexPath) as! listCell
        
        cell.dateLabel.text = dates[indexPath.row]
        cell.contentLabel.text = cnts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(alert, animated: true, completion: nil)
            //UIPasteboard.general.string = cnts[indexPath.row]
    }
    
}
