//
//  ViewController.swift
//  CopyNow
//
//  Created by 함의진 on 2016. 12. 24..
//  Copyright © 2016년 함의진. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tab:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tab)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var account:String?
    
    let alert = UIAlertController(title: "Info", message: "Content has been copied to your clipboard", preferredStyle: UIAlertControllerStyle.actionSheet)
    
    func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    var dates = [String]()
    var cnts = [String]()
    
    var indicator:ProgressIndicator?
    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        myTable.delegate = self;
        myTable.dataSource = self;
        
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: {action in
            self.displayShareSheet(shareContent: "[Copied from CopyNow for iOS]\n" + (UIPasteboard.general.string ?? ""))
            print("Copied")
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        myTable.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Loading...")
        self.view.addSubview(indicator!)
        
        getList()
    }

    func getList(){
        indicator!.start()
        let urlString = "http://yjham2002.woobi.co.kr/copynow/host.php?tr=106&id="
        let accountName = account
        
        let url = URL(string: urlString + (accountName ?? ""))
        let task = URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error ?? "None")
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:Any]]
                    for item in parsedData {
                        self.dates.append(item["dates"] as! String)
                        self.cnts.append(item["contents"] as! String)
                        
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.myTable.reloadData()
                self.indicator!.stop()
            }
        }
        task.resume()
        
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
        UIPasteboard.general.string = cnts[indexPath.row]
    }
    
}
