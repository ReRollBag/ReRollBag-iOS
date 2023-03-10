//
//  ReRollBagApp.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI
import GoogleMaps

class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Override point for customization after application launch.
    GMSServices.provideAPIKey(GOOGLE_API_KEY)

    return true
  }

}

@main
struct ReRollBagApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView{
                SignInView()
            }        }
    }
}
