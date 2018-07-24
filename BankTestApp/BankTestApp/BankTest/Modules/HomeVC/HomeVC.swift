
import UIKit

class HomeVC: BaseViewController, UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableViewNews: UITableView!
    var dataSource = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()        
        /**
         Call web service to fetch data and before thet checking the internet connection.
         If internet availble add loading indicator and start the actovity indicator
         
         - Parameter webAPI: URL.
         */
     
        if Reachability.shareManager.isConnectedToNetwork(){
            Share.shareManager.addLodingIndicator(viewController: self)
            let section =  "all-sections"
            let row = "1"
            let url = String(format: "%@/%@/%@.json?api-key=%@", WebAPI.baseURL,section,row,APIKEY)
            WebClient().getWebServiceCall(webAPI: url, completionHandler: { (responseObject) in
                Share.shareManager.stopLodingIndicator()
                self.dataSource  = responseObject as! [String : Any]
                DispatchQueue.main.async {
                    self.tableViewNews.isHidden = false
                    self.tableViewNews.reloadData()
                }
            }) { (error) in
                Share.shareManager.stopLodingIndicator()
                let errorMeassage = YINError.getErrorForCode(code: .UnknownError)
                self.showAlertbox(message: errorMeassage.description)
            }
        }
        else {
            self.showAlertbox(message: "Internet connectivity not there please reconnect and try again")
        }
 

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: Tableviewe delegate and Model–view–controller pattern.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let mediadic = dic["media"] as? [Dictionary<String,Any>]
        let metamediadicArry = mediadic![0] as Dictionary<String,Any>
        let metamediadicDic = metamediadicArry["media-metadata"] as! [Dictionary<String,Any>]
        cell.imageProfileView.downloadImageFrom(link: metamediadicDic[1]["url"] as! String, contentMode: .scaleAspectFit)
        cell.labelHeadLine.text = dic["abstract"] as? String
        cell.labelNewsCoverBy.text = dic["byline"] as? String
        cell.labelDate.text = dic["published_date"] as? String
        return cell
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
    }
    
    
//Segue delegate methods.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let indexPath = self.tableViewNews.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                let viewController:NewsDetailsVC = segue.destination as! NewsDetailsVC
                let dic = (dataSource["results"] as! [Dictionary<String,AnyObject>])[selectedRow]
                let mediadic = dic["media"] as? [Dictionary<String,Any>]
                let metamediadicArry = mediadic![0] as Dictionary<String,Any>
                let metamediadicDic = metamediadicArry["media-metadata"] as! [Dictionary<String,Any>]
                viewController.imageUrl = metamediadicDic[6]["url"] as? String
                viewController.imageDesc = dic["abstract"] as? String
                viewController.newsDesc = mediadic![0]["caption"] as? String
            }
    }
    
    //MARK: Show UIAlertController to the user for custom meassage for better inderstanding
    func showAlertbox(message:String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: NSLocalizedString("DemoApp", comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: {(okAlertAction: UIAlertAction) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAlertAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }

}

// UIImageView Extention to downalod the images.
extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
