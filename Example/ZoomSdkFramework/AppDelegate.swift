//
//  AppDelegate.swift
//  ZoomSdkFramework
//
//  Created by Mohamed-AbdulRaouf on 03/29/2022.
//  Copyright (c) 2022 Mohamed-AbdulRaouf. All rights reserved.
//

import UIKit
import ZoomSdkFramework
import MobileRTC

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let sdkKey = <#sdkKey#>
    let sdkSecret = <#sdkSecret#>

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let logger = Logger()
        logger.pringLog(log: "zoom init done")
        setupSDK(sdkKey: sdkKey, sdkSecret: sdkSecret)
        return true
    }

    func setupSDK(sdkKey: String, sdkSecret: String) {
        let context = MobileRTCSDKInitContext()
        context.domain = "zoom.us"
        context.enableLog = true
        context.appGroupId = ""
        let sdkInitializedSuccessfully = MobileRTC.shared().initialize(context)
        if sdkInitializedSuccessfully == true, let authorizationService = MobileRTC.shared().getAuthService() {
            authorizationService.clientKey = sdkKey
            authorizationService.clientSecret = sdkSecret
            authorizationService.delegate = self
            authorizationService.sdkAuth()
        }
        MobileRTC.shared().setLanguage("ar") // ar for Arabic language  , en for English
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: MobileRTCAuthDelegate {
    func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
        switch returnValue {
        case .success: //MobileRTCAuthError_Success:
            print("SDK successfully initialized.")
        case .keyOrSecretEmpty: //MobileRTCAuthError_KeyOrSecretEmpty:
            assertionFailure("SDK Key/Secret was not provided. Replace sdkKey and sdkSecret at the top of this file with your SDK Key/Secret.")
        case .keyOrSecretWrong, .unknown: //MobileRTCAuthError_KeyOrSecretWrong, MobileRTCAuthError_Unknown:
            assertionFailure("SDK Key/Secret is not valid.")
        default:
            assertionFailure("SDK Authorization failed with MobileRTCAuthError: (returnValue).")
        }
    }
}
