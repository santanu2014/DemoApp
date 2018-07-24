

import UIKit

class LoadingIndicatorView: UIView {
    //Outlet Connection for XIB
    @IBOutlet var firstLoadUserAlert: UILabel!
    @IBOutlet var lodingIndicator: UIActivityIndicatorView!
    //Load the Nib file
    class func instanceFromNib() -> LoadingIndicatorView {
        return Bundle.main.loadNibNamed("LoadingIndicatorView", owner: nil, options: nil)![0] as! LoadingIndicatorView
    }


}
