//
//  SceneDelegate.swift
//  Discourse_SoniaSieiro
//
//  Created by Sonia Sieiro on 17/03/2020.
//  Copyright © 2020 Sonia Sieiro. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
       
        
        let topicsVC  = TopicsViewController.init(nibName:  "TopicsViewController", bundle: nil)
        let categoriesVC = CategoriesViewController.init(nibName: "CategoriesViewController", bundle: nil)
        let usersVC    = UsersViewController.init(nibName: "UsersViewController", bundle: nil)
        
        topicsVC.tabBarItem  = UITabBarItem.init(title: "Topics", image: UIImage.init(systemName: "list.dash"), tag: 0)
        categoriesVC.tabBarItem   = UITabBarItem.init(title: "Categories", image: UIImage.init(systemName: "tag.fill"), tag: 1)
        usersVC.tabBarItem   = UITabBarItem.init(title: "Users", image: UIImage.init(systemName: "person.3.fill"), tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers  = [UINavigationController.init(rootViewController: topicsVC),
                                             UINavigationController.init(rootViewController: categoriesVC),
                                             UINavigationController.init(rootViewController: usersVC),
        ]
        
        
        tabBarController.tabBar.barStyle  = .black
        tabBarController.tabBar.isTranslucent  = true
        tabBarController.tabBar.tintColor = UIColor.white

        UINavigationBar.appearance().overrideUserInterfaceStyle = .dark
        UINavigationBar.appearance().tintColor = UIColor.white
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

