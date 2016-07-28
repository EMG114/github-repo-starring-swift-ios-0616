//
//  FISReposTableViewController.swift
//  github-repo-list-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    let store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        tableView.accessibilityIdentifier = "tableView"
        
        store.getRepositoriesWithCompletion {
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.repositories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath)

        let repository:GithubRepository = self.store.repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedRepo = store.repositories[indexPath.row]
        store.toggleStarStatusForRepository(selectedRepo) { (isStarred) in
            if isStarred {
                dispatch_async(dispatch_get_main_queue(), { 
                    self.createAlert("You just starred", repoFullName: selectedRepo.fullName)
                })
            }
            else {
                dispatch_async(dispatch_get_main_queue(), { 
                    self.createAlert("You just unstarred", repoFullName: selectedRepo.fullName)
                })
            }
        }
    }
    
    func createAlert(message: String, repoFullName: String) {
        let alertMessage = "\(message) \(repoFullName)"
        let alertController = UIAlertController(title: "Success!", message: alertMessage, preferredStyle: .Alert)
        alertController.accessibilityLabel = alertMessage
        let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(ok)
        ok.accessibilityLabel = "OK"
        self.presentViewController(alertController, animated: true, completion: nil)
    }
 

}
