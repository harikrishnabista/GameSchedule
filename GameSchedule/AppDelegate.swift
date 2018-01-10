//
//  AppDelegate.swift
//  GameSchedule
//
//  Created by Hari Krishna Bista on 1/6/18.
//  Copyright © 2018 yinzcam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var scheduleViewController:ScheduleViewController?
    var navigationViewController:UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Layouting the app theme
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.init(rgb: 0x233D48)        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white,NSAttributedStringKey.font: UIFont(name:"LeagueGothic-Regular", size:28) ?? UIFont.systemFont(ofSize: 21)]
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        if self.scheduleViewController == nil {
            self.scheduleViewController = ScheduleViewController()
            self.scheduleViewController?.view.frame = UIScreen.main.bounds
        }
        
        if self.navigationViewController == nil, let rootViewCon = self.scheduleViewController {
            self.navigationViewController = UINavigationController(rootViewController: rootViewCon)
            
            self.window = UIWindow()
            self.window?.frame = UIScreen.main.bounds
            self.window?.tintAdjustmentMode = .normal
            self.window?.rootViewController = self.navigationViewController
        }
        
        self.window?.backgroundColor = UIColor.white
        self.window?.clipsToBounds = false;
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

