//
//  JoinPartyViewController.swift


import UIKit

class JoinPartyViewController: UIViewController {
    @IBAction func joinPartyButton(_ sender: UIButton) {
        performSegue(withIdentifier: "guestPartySeg", sender: self)
        
    }
    var spotifyAccessToken: String?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "guestPartySeg") {
        let GuestPartyVC = segue.destination as! GuestPartyViewController
        GuestPartyVC.spotifyAccessToken = spotifyAccessToken
            GuestPartyVC.partyName = joinPartyName.text
        
    }
    }
    @IBOutlet weak var joinPartyName: UITextField!
    
    @IBOutlet weak var joinAccessCode: UITextField!
    
    @IBAction func joinPartyBtn(_ sender: UIButton) {
        joinParty()
        partySongs()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func joinParty(){//request: URLRequest) {
    let url = URL(string: "http://cgi.sice.indiana.edu/~team48/joinparty.php")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // HTTP Request Parameters which will be sent in HTTP Request Body
    let postString = "partyName=\(joinPartyName.text!)&accessCode=\(joinAccessCode.text!)";
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
    func partySongs(){//request: URLRequest) {
        let url = URL(string: "http://cgi.sice.indiana.edu/~team48/partysongs.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "partyName=\(joinPartyName.text!)";
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
}
