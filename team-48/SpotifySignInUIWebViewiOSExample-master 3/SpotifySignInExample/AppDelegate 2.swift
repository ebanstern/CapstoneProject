//
//  AppDelegate.swift


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate{
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
      print("connected")
    }
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
    print("failed")
    }
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
      print("disconnected")
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
      debugPrint("Track name: %@", playerState.track.name)
    }
    //func applicationWillResignActive(_ application: UIApplication) {
     // if self.appRemote.isConnected {
       // self.appRemote.disconnect()
    //  }
    //}
    //func applicationDidBecomeActive(_ application: UIApplication) {
      //if let _ = self.appRemote.connectionParameters.accessToken {
        //self.appRemote.connect()
      //}
    //}
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

