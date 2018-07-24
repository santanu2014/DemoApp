//
//  WebClient.swift
//  BankTestApp
//
//  Created by Santanu Koley on 24/07/18.
//  Copyright © 2018 Kode. All rights reserved.
//

import UIKit

class WebClient: NSObject {
    class  WebClient{
        static let sharedInstance = WebClient()
    }
    
    func getWebServiceCall(webAPI: String, completionHandler:@escaping (_ result: AnyObject) -> Void, failure:@escaping (Any)->Void){
        let url = URL(string: webAPI)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                failure(error!.localizedDescription as Any)
                return
            }
            do {
                let response = (try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any])!
                completionHandler(response as AnyObject)
                
            } catch _ as NSError {
                failure(error!.localizedDescription as Any)
            }
            
            }.resume()
    }
}
