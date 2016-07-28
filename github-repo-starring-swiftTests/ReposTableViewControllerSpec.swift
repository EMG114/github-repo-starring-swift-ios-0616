//
//  ReposTableViewControllerSpec.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Quick
import Nimble
import KIF

@testable import github_repo_starring_swift
class ReposTableViewControllerSpec: QuickSpec {

    override func spec() {
//        let window = UIApplication.sharedApplication().delegate?.window
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateInitialViewController()
//        
//        if let window = window, unwrappedWindow = window {
//            unwrappedWindow.rootViewController = vc
//            unwrappedWindow.makeKeyAndVisible()
//        }
        
        
        let tester = KIFUITestActor()
        let tableView = tester.waitForViewWithAccessibilityLabel("tableView") as! UITableView
        let indexPath = NSIndexPath(forRow: 1, inSection: 0)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        describe("TableView") {
            it("should have 1 section") {
                expect(tableView.numberOfSections).to(equal(1))
            }
            it("should have 2 cells") {
                expect(tableView.numberOfRowsInSection(0)).to(equal(2))
            }
        }
        describe("TableView Cells") {
            it("Should have the correct cells") {
                expect(cell?.textLabel?.text).to(equal("wycats/merb-core"))
            }
        }
        
//        describe("starring and unstarring repos") {
//            let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            it("should unstar a starred repo") {
//                delegate.starred = false
//                tester.waitForCellAtIndexPath(indexPath, inTableViewWithAccessibilityIdentifier: "tableView")
//                let tableView = tester.waitForViewWithAccessibilityLabel("tableView") as! UITableView
//                tester.tapRowAtIndexPath(indexPath, inTableViewWithAccessibilityIdentifier: "tableView")
//                
//                tester.waitForViewWithAccessibilityLabel("You just unstarred wycats/merb-core")
//                tester.tapViewWithAccessibilityLabel("OK")
//                tester.waitForAbsenceOfViewWithAccessibilityLabel("You just unstarred wycats/merb-core")
//            }
//            
//            it("should star an unstarred repo") {
//                delegate.starred = true
//                tester.tapRowAtIndexPath(indexPath, inTableViewWithAccessibilityIdentifier: "tableView")
//                
//                tester.waitForViewWithAccessibilityLabel("You just starred wycats/merb-core")
//                tester.tapViewWithAccessibilityLabel("OK")
//                tester.waitForAbsenceOfViewWithAccessibilityLabel("You just starred wycats/merb-core")
//            }
//        }
        
    }
    
}
