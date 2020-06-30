//
//  PartyInfoViewController.swift
//  SpotifySignInExample
//
//  Created by Eban Stern on 4/14/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import Foundation
class PartyInfoViewController: UIViewController{
    
    @IBOutlet weak var partyNameLabel: UILabel!
    var partyName: String?
    @IBOutlet weak var partyDescriptionLabel: UILabel!
    var partyDescription: String?
    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
       partyNameLabel.text = partyName
    partyDescriptionLabel.text = partyDescription //(partyDescriptionLabel.text)
    
    
    }
    
    
    
}
