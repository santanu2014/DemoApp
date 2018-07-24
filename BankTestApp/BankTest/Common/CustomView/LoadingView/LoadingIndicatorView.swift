

import UIKit

class LoadingIndicatorView: UIView {

    @IBOutlet var firstLoadUserAlert: UILabel!
    @IBOutlet var lodingIndicator: UIActivityIndicatorView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func instanceFromNib() -> LoadingIndicatorView {
        return Bundle.main.loadNibNamed("LoadingIndicatorView", owner: nil, options: nil)![0] as! LoadingIndicatorView
    }


}
