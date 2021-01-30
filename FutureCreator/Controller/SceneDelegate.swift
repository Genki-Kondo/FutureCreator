//
//  SceneDelegate.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/17.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //端末の画面の大きさを取得
        let storyboard:UIStoryboard = self.grabStoryboard()
        //表示するstoryBoardをセット！
        if let window = window{
            window.rootViewController = storyboard.instantiateInitialViewController() as UIViewController?
            }
        self.window?.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func grabStoryboard() -> UIStoryboard{
                var storyboard = UIStoryboard()
                let height = UIScreen.main.bounds.size.height
                //iPhone6,6s,7,8,SE2
                if height == 667 {
                    storyboard = UIStoryboard(name: "Main", bundle: nil)
                //iPhone6,6s,7,8plus
                }else if height == 736 {
                    storyboard = UIStoryboard(name: "iPhone8plus", bundle: nil)
                //iPhone10,10s,11Pro
                }else if height == 812{
                    storyboard = UIStoryboard(name: "iPhone10,10s,11Pro,12mini", bundle: nil)
                //iPhone 12,12Pro
                }else if height == 844{
                    storyboard = UIStoryboard(name: "iPhone12,12Pro", bundle: nil)
                //iPhone11ProMax
                }else if height == 896{
                    storyboard = UIStoryboard(name: "iPhone11,11ProMax", bundle: nil)
                //iPadPro9.7
                }else if height == 1024{
                    storyboard = UIStoryboard(name: "iPadPro9.7", bundle: nil)
                //iPad7th,8th
                }else if height == 1080{
                    storyboard = UIStoryboard(name: "iPad7,8th", bundle: nil)
                //iPadAir3th
                }else if height == 1112{
                    storyboard = UIStoryboard(name: "iPadPro10.5,Air3th", bundle: nil)
                //iPadAir4th
                }else if height == 1180{
                    storyboard = UIStoryboard(name: "iPadAir4th", bundle: nil)
                //iPadPro11(2th)
                }else if height == 1194{
                    storyboard = UIStoryboard(name: "iPadPro11(2th)", bundle: nil)
                //iPadPro12.9(3,4th)
                }else if height == 1366{
                    storyboard = UIStoryboard(name: "iPadPro12.9(3,4th)", bundle: nil)
                //iPad
                }else{
//                    switch UIDevice.current.model {
//                    case "iPnone" :
//                    storyboard = UIStoryboard(name: "se", bundle: nil)
//                        break
//                    case "iPad" :
//                    storyboard = UIStoryboard(name: "iPad", bundle: nil)
//                    print("iPad")
//                        break
//                    default:
//                        break
//                    }
                }
                return storyboard
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

