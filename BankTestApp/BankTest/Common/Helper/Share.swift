//
//  Share.swift
//  BankTestApp
//
//  Created by Santanu Koley on 24/07/18.
//  Copyright © 2018 Kode. All rights reserved.
//

import UIKit

class Share: NSObject {
    static let shareManager = Share()
    var lodingIndicatorView : LoadingIndicatorView!
    var viewCtrl:UIViewController!
    func addLodingIndicator(viewController:UIViewController){
        DispatchQueue.main.async {
            UIApplication.shared.beginIgnoringInteractionEvents()
            let screenSize: CGRect = UIScreen.main.bounds
            self.viewCtrl = viewController
            self.lodingIndicatorView = LoadingIndicatorView.instanceFromNib()
            self.lodingIndicatorView.frame = CGRect(x:0,y:0,width:screenSize.width,height:screenSize.height)
            viewController.view.addSubview(self.lodingIndicatorView)
            self.lodingIndicatorView.lodingIndicator.startAnimating()
        }
    }
    
    /**
     Remove the UIActivity indicator and stop the activity indicator.
     -Parameter viewCntroller : Current UIViewController Ref.
     */
    func stopLodingIndicator(){
        DispatchQueue.main.async {
            UIApplication.shared.endIgnoringInteractionEvents()
            if self.lodingIndicatorView == nil {
                return
            }
            //self.viewCtrl.view.window?.isUserInteractionEnabled = true
            self.lodingIndicatorView.lodingIndicator.stopAnimating()
            self.lodingIndicatorView.removeFromSuperview()
        }
    }

}
