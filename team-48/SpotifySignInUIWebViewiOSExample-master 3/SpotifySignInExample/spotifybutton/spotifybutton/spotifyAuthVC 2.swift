//
//  spotifyAuthVC.swift
//  spotifybutton
//
//  Created by Edward Smith on 2/20/20.
//  Copyright © 2020 Edward Smith. All rights reserved.
//

import Foundation
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

IBAction func spotifyLoginAction(_ sender: UIButton) {
spotifyAuthVC()
    
var webView = WKWebView()
func spotifyAuthVC() {
    // Create Spotify Auth ViewController
    let spotifyVC = UIViewController()
    // Create WebView
    let webView = WKWebView()
    webView.navigationDelegate = self
    spotifyVC.view.addSubview(webView)
    webView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        webView.topAnchor.constraint(equalTo: spotifyVC.view.topAnchor),
        webView.leadingAnchor.constraint(equalTo: spotifyVC.view.leadingAnchor),
        webView.bottomAnchor.constraint(equalTo: spotifyVC.view.bottomAnchor),
        webView.trailingAnchor.constraint(equalTo: spotifyVC.view.trailingAnchor)
        ])

    let authURLFull = "https://accounts.spotify.com/authorize?response_type=token&client_id=" + SpotifyConstants.CLIENT_ID + "&scope=" + SpotifyConstants.SCOPE + "&redirect_uri=" + SpotifyConstants.REDIRECT_URI + "&show_dialog=false"

    let urlRequest = URLRequest.init(url: URL.init(string: authURLFull)!)
    webView.load(urlRequest)

    // Create Navigation Controller
    let navController = UINavigationController(rootViewController: spotifyVC)
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
    spotifyVC.navigationItem.leftBarButtonItem = cancelButton
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
    spotifyVC.navigationItem.rightBarButtonItem = refreshButton
    let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navController.navigationBar.titleTextAttributes = textAttributes
    spotifyVC.navigationItem.title = "spotify.com"
    navController.navigationBar.isTranslucent = false
    navController.navigationBar.tintColor = UIColor.white
    navController.navigationBar.barTintColor = UIColor.black
    navController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
    navController.modalTransitionStyle = .coverVertical

    self.present(navController, animated: true, completion: nil)
}

@objc func cancelAction() {
    self.dismiss(animated: true, completion: nil)
}

@objc func refreshAction() {
    self.webView.reload()
}
}
