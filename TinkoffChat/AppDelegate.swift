//
//  AppDelegate.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 20.09.17.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var currentAppState: String!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        currentAppState = getAppState(state: application.applicationState)
        print("Application moved to \(currentAppState!) state: \(#function)")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        var state = "Application moved from \(currentAppState!)"
        currentAppState = getAppState(state: application.applicationState)
        state += " to \(currentAppState!) state: \(#function)"
        
        print(state)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        var state = "Application moved from \(currentAppState!)"
        currentAppState = getAppState(state: application.applicationState)
        state += " to \(currentAppState!) state: \(#function)"
        
        print(state)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        var state = "Application moved from \(currentAppState!)"
        currentAppState = getAppState(state: application.applicationState)
        state += " to \(currentAppState!) state: \(#function)"
        
        print(state)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        var state = "Application moved from \(currentAppState!)"
        currentAppState = getAppState(state: application.applicationState)
        state += " to \(currentAppState!) state: \(#function)"
        
        print(state)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        var state = "Application moved from \(currentAppState!)"
        currentAppState = getAppState(state: application.applicationState)
        state += " to \(currentAppState!) state: \(#function)"
        
        print(state)
    }
    
    func getAppState(state: UIApplicationState) -> String {
        switch state {
        case .active:
            return "Active"
        case .inactive:
            return "Inactive"
        case .background:
            return "Background"
        }
    }

}

