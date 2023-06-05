//
//  ReRollBagApp.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI
import GoogleMaps
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Override point for customization after application launch.
    GMSServices.provideAPIKey(GOOGLE_API_KEY)
    FirebaseApp.configure()
    return true
  }

}

@main
struct ReRollBagApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView{
                AuthView()
            }
        }
    }
}
