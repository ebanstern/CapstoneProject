//
//  AudioVC.swift
//  SpotifySignInExample
//
//  Created by Eban Stern on 4/15/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class AudioVC: UIViewController {
    
    var image = UIImage()
    var mainSongTitle=String()
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var background: UIImageView!

    @IBOutlet var songTitle: UILabel!
    
    var mainpreviewURL = String()
   
    override func viewDidLoad() {
        songTitle.text = mainSongTitle
        background.image = image
        mainImageView.image = image
    }
    

    
    
    
}
