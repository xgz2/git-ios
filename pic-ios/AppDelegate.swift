//
//  AppDelegate.swift
//  pic-ios
//
//  Created by George Zhuang on 7/13/20.
//  Copyright © 2020 George, Jonna, Judy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let layout = UICollectionViewFlowLayout()
//        window?.rootViewController = UINavigationController(rootViewController: PageCollectionViewController(collectionViewLayout: layout))
        window?.rootViewController = UINavigationController(rootViewController: ContainerPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil))
        
        return true
    }

}
