//
//  DetailsViewController.swift


import UIKit
import Alamofire


//public extension URLRequest {
    /// Returns the `httpMethod` as Alamofire's `HTTPMethod` type.
   // var method: HTTPMethod? {
       // get { return httpMethod.flatMap(HTTPMethod.init) }
       // set { httpMethod = newValue?.rawValue }
   // }
//}

class DetailsViewController:UIViewController {
    
    var spotifyAccessToken: String?
    @IBAction func startPartyButton(_ sender: Any) {
        performSegue(withIdentifier: "startParty", sender: self)
    }
    @IBAction func joinPartyButton(_ sender: Any) {
        performSegue(withIdentifier: "joinPartySeg", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "startParty") {
        let PartyVC = segue.destination as! PartyViewController
        PartyVC.spotifyAccessToken = spotifyAccessToken
        
    }
        else if(segue.identifier == "joinPartySeg") {
            let JoinPartyVC = segue.destination as! JoinPartyViewController
            JoinPartyVC.spotifyAccessToken = spotifyAccessToken
            
        }
    }
    
    
    //public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
      //  public static let connect = HTTPMethod(rawValue: "CONNECT")
        //public static let delete = HTTPMethod(rawValue: "DELETE")
        //public static let get = HTTPMethod(rawValue: "GET")
        //public static let head = HTTPMethod(rawValue: "HEAD")
        //public static let options = HTTPMethod(rawValue: "OPTIONS")
        //public static let patch = HTTPMethod(rawValue: "PATCH")
        //public static let post = HTTPMethod(rawValue: "POST")
        //public static let put = HTTPMethod(rawValue: "PUT")
        //public static let trace = HTTPMethod(rawValue: "TRACE")

        //public let rawValue: String

        //public init(rawValue: String) {
          //  self.rawValue = rawValue
        //}
    //}
    
    
    //@IBOutlet weak var spotifyIdLabel: UILabel!
    //@IBOutlet weak var spotifyDisplayNameLabel: UILabel!
    //@IBOutlet weak var spotifyEmailLabel: UILabel!
    //@IBOutlet weak var spotifyAvatarUrlLabel: UILabel!
    //@IBOutlet weak var spotifyAccessTokenLabel: UILabel!
    
    
    //var spotifyId = ""
    //var spotifyDisplayName = ""
    //var spotifyEmail = ""
    //var spotifyAvatarURL = ""
    //var spotifyAccessToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //spotifyIdLabel.text = spotifyId
        //spotifyDisplayNameLabel.text = spotifyDisplayName
        //spotifyEmailLabel.text = spotifyEmail
        //spotifyAvatarUrlLabel.text = spotifyAvatarURL
        //spotifyAccessTokenLabel.text = spotifyAccessToken
    }
    
    //Alamofire Post try

   // struct postUser: Codable {
          //   let userToken: String
          //   let userID: String
           //  let userName: String
          //   let email: String
         //    let userAvURL: String
        // }

  //  let parameters = postUser [userToken: spotifyAccessToken, userID: spotifyId, userName: spotifyDisplayName, email: spotifyEmail, userAvURL: spotifyAvatarURL]
             
    //     AF.request("http://cgi.soic.indiana.edu/~team48/adduser.php",
       //         method: .post,
     //           parameters: parameters,
       //         encoder: JSONParameterEncoder.default).response { response in
     //    debugPrint(response)

    
    
    
    
}
    
    


