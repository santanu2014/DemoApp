//
//  NewsDetailsVC.swift
//  BankTestApp
//
//  Created by Santanu Koley on 24/07/18.
//  Copyright © 2018 Kode. All rights reserved.
//

import UIKit

class NewsDetailsVC: BaseViewController {

    @IBOutlet weak var textViewDetailsNews: UITextView!
    @IBOutlet weak var labelImageDesc: UILabel!
    @IBOutlet weak var newsBigImageView: UIImageView!
    
    var imageUrl: String?
    var imageDesc:String?
    var newsDesc:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //addSlideMenuButton()
        // Do any additional setup after loading the view.
        //To up the UI based in previous data
        DispatchQueue.main.async {
            self.newsBigImageView.downloadImageFrom(link: self.imageUrl!, contentMode: .scaleAspectFit)
            self.labelImageDesc.text = self.imageDesc
            self.textViewDetailsNews.text = self.newsDesc
            self.navigationItem.title = "Details"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
