//
//  PartyViewController.swift

//

import UIKit

class PartyViewController: UIViewController {
    let SpotifyClientID = SpotifyConstants.CLIENT_ID
    let SpotifyRedirectURL = URL(string: SpotifyConstants.REDIRECT_URI)!
    
    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )
    
    func HideKeyboard(){
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      let parameters = appRemote.authorizationParameters(from: url);

            if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
                appRemote.connectionParameters.accessToken = access_token
                self.spotifyAccessToken = access_token
            } else if (parameters?[SPTAppRemoteErrorDescriptionKey]) != nil {
                // Show the error
            }
      return true
    }
    lazy var appRemote: SPTAppRemote = {
      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
      appRemote.connectionParameters.accessToken = self.spotifyAccessToken
        appRemote.delegate = self as? SPTAppRemoteDelegate
      return appRemote
    }()
    var playURI = "spotify:track:20I6sIOMTCkB6w7ryavxtO"
    func connect() {
      self.appRemote.authorizeAndPlayURI(self.playURI)
    }

    // CALLS LOGIN VC
    var LoginViewController:LoginViewController?
    
    @IBOutlet weak var partyName: UITextField!
    @IBOutlet weak var PartyCode: UITextField!
    @IBOutlet weak var partyDescription: UITextField!
    var spotifyAccessToken: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    if(segue.identifier == "partyVCtoGuestPartyVC") {
        let GuestPartyVC = segue.destination as! GuestPartyViewController
        GuestPartyVC.partyName = partyName.text
        GuestPartyVC.partyDescription = partyDescription.text
        GuestPartyVC.spotifyAccessToken = spotifyAccessToken
        GuestPartyVC.accessCode = PartyCode.text
        
    }
        

        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.HideKeyboard()
    }
    var token = String()
    
    @IBAction func startParty(_ sender: UIButton) {

        
        
        //LoginViewController?.fetchSpotifyProfile(accessToken )
        func getHostToken(token: String) {
            self.token = LoginViewController!.spotifyAccessToken
    }
        
        postParty()
    
    }
    
   func postParty(){//request: URLRequest) {
   let url = URL(string: "http://cgi.sice.indiana.edu/~team48/postparty.php")!
   var request = URLRequest(url: url)
   request.httpMethod = "POST"
   // HTTP Request Parameters which will be sent in HTTP Request Body
    let postString = "partyName=\(partyName.text!)&accessCode=\(PartyCode.text!)&partyDescription=\(partyDescription.text!)&hostToken=\(spotifyAccessToken!)";
   // Set HTTP Request Body
   request.httpBody = postString.data(using: String.Encoding.utf8);
   let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
       if let error = error {
           print("error: \(error)")
       } else {
           if let response = response as? HTTPURLResponse {
               print("statusCode: \(response.statusCode)")
           }
           if let data = data, let dataString = String(data: data, encoding: .utf8) {
               print("data: \(dataString)")
           }
       }
   }
   task.resume()
   
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
