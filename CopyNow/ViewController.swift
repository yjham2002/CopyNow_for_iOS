//
//  ViewController.swift
//  CopyNow
//
//  Created by 함의진 on 2016. 12. 24..
//  Copyright © 2016년 함의진. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let dates = ["2014","2015","2016"]
    let cnts = ["swift","iOS","Testing"]
    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.delegate = self;
        myTable.dataSource = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return dates.count
    }
    
    // 각 row 마다 데이터 세팅.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath as IndexPath) as! listCell
        
        cell.dateLabel.text = dates[indexPath.row]
        cell.contentLabel.text = cnts[indexPath.row]
        
        return cell
    }
    
}
