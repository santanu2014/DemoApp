//
//  NewsDetailsVC.swift
//  BankTestApp
//
//  Created by Santanu Koley on 24/07/18.
//  Copyright © 2018 Kode. All rights reserved.
//

import UIKit

class NewsDetailsVC: BaseViewController {
    //Outlet Connection for XIB
    @IBOutlet weak var textViewDetailsNews: UITextView!
    @IBOutlet weak var labelImageDesc: UILabel!
    @IBOutlet weak var newsBigImageView: UIImageView!
    
    //Decalre the class label variables.
    var imageUrl: String?
    var imageDesc:String?
    var newsDesc:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Calling Async method to update UI on main thread.
        DispatchQueue.main.async {
            self.newsBigImageView.downloadImageFrom(link: self.imageUrl!, contentMode: .scaleAspectFit)
            self.labelImageDesc.text = self.imageDesc
            self.textViewDetailsNews.text = self.newsDesc
            self.navigationItem.title = "Details"
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
