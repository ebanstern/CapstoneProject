//
//  AudioVC.swift
//  SpotifySignInExample
//<<<<<<< HEAD
//=======
//
//  Created by Eban Stern on 4/15/20.
// 
//
//>>>>>>> master

import Foundation
import UIKit
import AVFoundation


class AudioVC: UIViewController {
    
    var image = UIImage()
    var mainSongTitle=String()
    var mainpreviewURL = String()
    @IBOutlet var playpausebtn: UIButton!
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var background: UIImageView!

    @IBOutlet var songTitle: UILabel!
    
    
   
    override func viewDidLoad() {
        songTitle.text = mainSongTitle
        background.image = image
        mainImageView.image = image
        
        downloadFileFromURL(url: URL(string: mainpreviewURL)!)
        playpausebtn.setTitle("Pause", for: .normal)
        
    }
    

    func downloadFileFromURL(url:URL){
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: {
            customURL, response, error in
            self.play(url: customURL!)
            
            
        })
        
        downloadTask.resume()
    }
    
    func play(url: URL){
        do{
           player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        }
        catch{
            print(error)
    }
    
    
}
    @IBAction func pauseplay(_ sender: Any) {
        if player.isPlaying{
            player.pause()
            playpausebtn.setTitle("Play", for: .normal)
        }
        else{
            player.play()
            playpausebtn.setTitle("Pause", for: .normal)
        }
    }
}
