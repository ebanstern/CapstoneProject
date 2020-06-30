//
//  GuestPartyViewController.swift


import UIKit
import Alamofire
import AVFoundation
var player : AVAudioPlayer!
var songURL: String?


struct post {
    let mainImage : UIImage!
    let name : String!
    //establish preview url
    let previewURL : String?

}
class GuestPartyViewController: UITableViewController,UISearchBarDelegate {
    let SpotifyClientID = SpotifyConstants.CLIENT_ID
    let SpotifyRedirectURL = URL(string: SpotifyConstants.REDIRECT_URI)!


    @IBOutlet var seachBar: UISearchBar!
    var spotifyAccessToken: String?
    lazy var searchURL = String()
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keywords = searchBar.text
        let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+")
        searchURL = "https://api.spotify.com/v1/search?q=\(finalKeywords!)&market=US&type=track&limit=10&access_token=\(spotifyAccessToken!)"
        print(searchURL)
        callAlamo(url: searchURL)
        self.view.endEditing(true)
        songURL = searchURL
        
    }
    
   
    typealias JSONStandard = [String : AnyObject]
    var posts = [post]()
    
    var partyName: String?
    var partyDescription: String?
    var accessCode: String?
        

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
    
    //post song func
    func postSong(){//request: URLRequest) {
    let url = URL(string: "http://cgi.sice.indiana.edu/~team48/songs.php")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "songURL=\(songURL!)&partyName=\(partyName!)";
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
    }

        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
     func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "guestPartySeg") {
        let PartyInfoVC = segue.destination as! PartyInfoViewController
            PartyInfoVC.partyDescription = partyDescription
            PartyInfoVC.partyName = partyName
            PartyInfoVC.accessCode = accessCode
        }
        }
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: Selector("editButtonPressed"))

    }
    
    
    /*@IBAction func editButtonPressed(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    

    func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: Selector("editButtonPressed"))
      }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: Selector("editButtonPressed"))
      }
    }*/
    
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
                        //print(item)
                        let previewURL = item["preview_url"] as? String ?? "https://p.scdn.co/mp3-preview/c3bb27c99f342a9349af5f905dbb74fbe588a35a?cid=922a54e93f8744859b557baf2c9dd56e"
                        print(previewURL)
                        if let album = item["album"] as? JSONStandard{
                            if let images = album["images"] as? [JSONStandard]{
                                let imageData = images[0]
                                let mainImageUrl = URL(string: imageData["url"] as! String)
                                let mainImageData = NSData(contentsOf: mainImageUrl!)
                                let mainImage = UIImage(data: mainImageData as! Data)
                                posts.append(post.init(mainImage: mainImage, name: name, previewURL: previewURL))
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
    //establishes the tableview of songs
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        mainImageView.image = posts[indexPath.row].mainImage
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        mainLabel.text = posts[indexPath.row].name
        //posts song info to DB
        func postTitles(){//request: URLRequest) {
            let url = URL(string: "http://cgi.sice.indiana.edu/~team48/songs.php")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            // HTTP Request Parameters which will be sent in HTTP Request Body
            let postString = "songTitle=\(mainLabel.text!)&partyName=\(partyName!)";
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
                        //let
                        //format/save data returned here?
                    }
                }
            }
            task.resume()

        }
        postTitles()
        return cell!
    }
    // Post songs to db here?
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    /*override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.posts[sourceIndexPath.row]
        posts.remove(at: sourceIndexPath.row)
        posts.insert(movedObject, at: destinationIndexPath.row)
        debugPrint("\(sourceIndexPath.row) => \(destinationIndexPath.row)")
        self.tableView.reloadData()
    }*/

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    if(segue.identifier == "partyInfoSeg") {
        let PartyInfoVC = segue.destination as! PartyInfoViewController
        PartyInfoVC.partyName = partyName
        PartyInfoVC.partyDescription = partyDescription
        PartyInfoVC.accessCode = accessCode
    }
    else if(segue.identifier == "audioVCSeg"){
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        let vc = segue.destination as! AudioVC
        vc.image = posts[indexPath!].mainImage
        vc.mainSongTitle = posts[indexPath!].name
        vc.mainpreviewURL = posts[indexPath!].previewURL ?? "https://p.scdn.co/mp3-preview/c3bb27c99f342a9349af5f905dbb74fbe588a35a?cid=922a54e93f8744859b557baf2c9dd56e"
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
