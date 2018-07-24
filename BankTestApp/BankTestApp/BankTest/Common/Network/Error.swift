
import UIKit

enum EGErrorCode : Int {
    case NoError
    case AuthenticationFailureError
    case OtherError
    case ServerError
    case UnknownError
}
private let YIN_ERROR_DOMAIN = "api.nytimes.com"


class YINError: NSObject {
    
    class func getErrorForCode(code : EGErrorCode) ->NSError {
        var errorDescription = "DefaultError"
        switch code {
        case .AuthenticationFailureError:
            errorDescription = "Your session timeout occured."
        case .OtherError :
            errorDescription = "Server error occured."
        case .ServerError :
            errorDescription = "Server error occured."
        case .UnknownError:
            errorDescription = "Something went wrong."
               default:
            break
        }
        
        let userInfo = [NSLocalizedDescriptionKey : errorDescription]
        return NSError(domain: YIN_ERROR_DOMAIN, code: code.rawValue, userInfo: userInfo)
    }

}
