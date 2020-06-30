//
//  GuestPartyViewController.swift


import UIKit
import Alamofire
import AVFoundation



struct post {
    let mainImage : UIImage!
    let name : String!
    //let previewURL : String!
}
class GuestPartyViewController: UITableViewController,UISearchBarDelegate {
    let SpotifyClientID = SpotifyConstants.CLIENT_ID
    let SpotifyRedirectURL = URL(string: SpotifyConstants.REDIRECT_URI)!
    
    lazy var searchURL = "https://api.spotify.com/v1/search?q=Kanye%20West&type=track&access_token=\(spotifyAccessToken!)"
    typealias JSONStandard = [String : AnyObject]
    var posts = [post]()
    
    var partyName: String?
    var partyDescription: String?
    
    @IBOutlet var searchBar: UISearchBar!
    var spotifyAccessToken: String?
    
    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
        
        callAlamo(url: searchURL)
        }
    
    func callAlamo(url:String){
        AF.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
    
    }
    func parseData(JSONData: Data){
        do{
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let tracks = readableJSON["tracks"] as? JSONStandard{
                if let items = tracks["items"] as? [JSONStandard] {
                    for i in 0..<items.count{
                        let item = items[i]
                        let name = item["name"] as! String
                        print(item)
                        //let previewURL = item["preview_url"] as! String
                        if let album = item["album"] as? JSONStandard{
                            if let images = album["images"] as? [JSONStandard]{
                                let imageData = images[0]
                                let mainImageUrl = URL(string: imageData["url"] as! String)
                                let mainImageData = NSData(contentsOf: mainImageUrl!)
                                let mainImage = UIImage(data: mainImageData as! Data)
                                posts.append(post.init(mainImage: mainImage, name: name))
                                self.tableView.reloadData()

                            }

                        }
                    }
                }
            }
        }
        catch{
        print(error)
    }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        mainImageView.image = posts[indexPath.row].mainImage
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        mainLabel.text = posts[indexPath.row].name
        return cell!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    if(segue.identifier == "partyInfoSeg") {
        let PartyInfoVC = segue.destination as! PartyInfoViewController
        PartyInfoVC.partyName = partyName
        PartyInfoVC.partyDescription = partyDescription
    }
    else if(segue.identifier == "audioVCSeg"){
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        let vc = segue.destination as! AudioVC
        vc.image = posts[indexPath!].mainImage
        vc.mainSongTitle = posts[indexPath!].name
        //vc.mainpreviewURL = posts[indexPath!].previewURL
    }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */




}
