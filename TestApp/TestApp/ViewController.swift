//
//  ViewController.swift
//  TestApp
//
//  Created by Santanu Koley on 23/07/18.
//  Copyright © 2018 Santanu Koley. All rights reserved.
//

import UIKit

class ViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableViewNews: UITableView!
    var dataSource = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableViewNews.dataSource = self
        tableViewNews.delegate = self
        
        addSlideMenuButton()

        
       // self.tableViewNews.register(NewsViewCell.self, forCellReuseIdentifier: "cellId")

        let url = URL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json?api-key=6fbe275b04c1468e8b064f1e9353fd25")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if error ! = nil do {
//                print(error)
//                return
//            }
            do {
                self.dataSource = (try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any])!
                DispatchQueue.main.async {
                    self.tableViewNews.reloadData()
                }
                
            } catch {
                
                
            }
            
            
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataSource.count,dataSource)
        if let dataSource = dataSource["results"] as? [Dictionary<String,AnyObject>]{
            return dataSource.count
        }
        
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsViewCell = (tableView.dequeueReusableCell(withIdentifier: "cellId") as! NewsViewCell?)!
        let dic = (dataSource["results"] as! [Dictionary<String,AnyObject>])[indexPath.row]
        cell.labelHeadLine.text = dic["adx_keywords"] as? String
        cell.labelDate.text = dic["published_date"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }


}

