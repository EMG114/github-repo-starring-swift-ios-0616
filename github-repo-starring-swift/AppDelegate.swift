//
//  AppDelegate.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/29/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import OHHTTPStubs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var starred: Bool!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if isRunningTests() == true {
            starred = true
            
            //stubbing GET repositories
            OHHTTPStubs.stubRequestsPassingTest({ (request) -> Bool in
                return(request.URL?.host == "api.github.com" && request.URL?.path == "/repositories")
                
            }) { (request) -> OHHTTPStubsResponse in
                return OHHTTPStubsResponse(fileAtPath: OHPathForFileInBundle("repositories.json", NSBundle(forClass: self.dynamicType))!, statusCode: 200, headers: ["Content-Type" : "application/json"])
            }
            
            //stubbing GET star status
            OHHTTPStubs.stubRequestsPassingTest({ (request) -> Bool in
                return(request.URL?.host == "api.github.com" && request.URL?.path == "/user/starred/wycats/merb-core")
                
            }) { (request) -> OHHTTPStubsResponse in
                if self.starred == true {
                    return OHHTTPStubsResponse(data: NSData(), statusCode: 204, headers: nil)
                }
                else {
                    return OHHTTPStubsResponse(fileAtPath: OHPathForFileInBundle("not_starred.json", NSBundle(forClass: self.dynamicType))!, statusCode: 404, headers: ["Content-Type" : "application/json"])
                }
                
            }
            
            //stubbing PUT/DELETE star
            OHHTTPStubs.stubRequestsPassingTest({ (request) -> Bool in
                let urlCheck = (request.URL?.host == "api.github.com" && request.URL?.path == "/user/starred/wycats/merb-core")
                let httpMethodCheck = (request.HTTPMethod == "PUT" || request.HTTPMethod == "DELETE")
                return urlCheck && httpMethodCheck
                
            }) { (request) -> OHHTTPStubsResponse in
                return OHHTTPStubsResponse(data: NSData(), statusCode: 204, headers: nil)
            }
        }
        
        
        
        return true
    }
    
    func isRunningTests() -> Bool {
        let env = NSProcessInfo.processInfo().environment
        if let injectBundle = env["XCTestConfigurationFilePath"] {
            return NSString(string: injectBundle).pathExtension == "xctestconfiguration"
        }
        return false
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

