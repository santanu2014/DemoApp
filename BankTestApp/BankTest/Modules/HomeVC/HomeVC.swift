
import UIKit

class HomeVC: BaseViewController, UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableViewNews: UITableView!
    var dataSource = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        // Do any additional setup after loading the view.
        
        Share.shareManager.addLodingIndicator(viewController: self)
        /**
         Call web service to fetch data
         
         - Parameter webAPI: URL.
         */
        WebClient().getWebServiceCall(webAPI: WebAPI.baseURL, completionHandler: { (responseObject) in
            Share.shareManager.stopLodingIndicator()
            self.dataSource  = responseObject as! [String : Any]
            DispatchQueue.main.async {
                self.tableViewNews.isHidden = false
                self.tableViewNews.reloadData()
            }
        }) { (error) in
            Share.shareManager.stopLodingIndicator()
            print(error)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Tableviewe delegate and Model–view–controller pattern
    
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
        print("You tapped cell number \(indexPath.row).")
    }
    
    
//Seg deleagte methods//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsNews" {
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
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// UIImageView Extention to downalod the images
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
