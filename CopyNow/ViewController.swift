//
//  ViewController.swift
//  CopyNow
//
//  Created by 함의진 on 2016. 12. 24..
//  Copyright © 2016년 함의진. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var clip: UITextField!
    
    var account:String?
    
    let alert = UIAlertController(title: "Info", message: "Content has been copied to your clipboard", preferredStyle: UIAlertControllerStyle.actionSheet)
    
    func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    func onUpload(content:String?){
        if (content?.isEmpty)!{
            return
        }
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let currentTime = "\(year)-\(month)-\(day) \(hour):\(minutes):\(seconds)"
        
        var request:URLRequest?
        
        let mapDict = [ "id":account ?? "", "date":currentTime, "cont":content ?? ""] as [String : Any]
        do{
            
            let jsonData = try JSONSerialization.data(withJSONObject: mapDict, options: .prettyPrinted)
            let urlString = URL(string : "http://yjham2002.woobi.co.kr/copynow/host.php?tr=109")
            request = URLRequest(url: urlString!)
            request?.httpMethod = "POST"
            request?.httpBody = jsonData
            request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request?.addValue("application/json", forHTTPHeaderField: "Accept")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with:request!){ data,response,error in
            if error != nil{
                print(error ?? "")
                return
            }
            do{
                if let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]{
                print(responseJSON)
                }
            } catch let error as NSError {
                print(mapDict)
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
    }
    
    @IBAction func onAdd(_ sender: Any) {
            onUpload(content: clip.text)
    }
    
    var dates = [String]()
    var cnts = [String]()
    
    var indicator:ProgressIndicator?
    
    @IBOutlet weak var myTable: UITableView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    print("JSON Parsing Started")
                    if let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]]{
                        print("JSON Parsing loop")
                        for item in parsedData.reversed() {
                            self.dates.append(item["dates"] as! String)
                            self.cnts.append(item["contents"] as! String)
                            
                        }
                    }else{
                        print("Empty Set returned")
                    }
                    
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
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
