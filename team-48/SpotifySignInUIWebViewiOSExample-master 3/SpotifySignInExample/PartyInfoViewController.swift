//
//  PartyInfoViewController.swift
//

import Foundation
class PartyInfoViewController: UIViewController{
    
    @IBOutlet weak var partyNameLabel: UILabel!
    var partyName: String?
    @IBOutlet weak var partyDescriptionLabel: UILabel!
    var partyDescription: String?
    
    @IBOutlet var accessCodeLabel: UILabel!
    var accessCode: String?
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
       partyNameLabel.text = partyName
    partyDescriptionLabel.text = partyDescription //(partyDescriptionLabel.text)
        accessCodeLabel.text = accessCode
    
    
    }
    
    
    
}
