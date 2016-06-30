//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    //KEEP THIS FOR MASTER
    class func getRepositoriesWithCompletion(completion: (NSArray) -> ()) {
        let urlString = "\(githubAPIURL)/repositories?client_id=\(githubClientID)&client_secret=\(githubClientSecret)"
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSArray {
                if let responseArray = responseArray {
                    completion(responseArray)
                }
            }
        }
        task.resume()
    }
    
    class func checkIfRepositoryIsStarred(fullName: String, completion: (Bool) -> ()) {
        let urlString = "\(githubAPIURL)/repositories?client_id=\(githubClientID)&client_secret=\(githubClientSecret)&access_token=\(githubAccessToken)"
        guard let url = NSURL(string: urlString) else { assertionFailure("Invalid URL"); return }
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            guard let httpResponse = response as? NSHTTPURLResponse else { assertionFailure("Unable to get response \(error?.localizedDescription)"); return }
            if httpResponse.statusCode == 204 {
                completion(true)
            }
            else if httpResponse.statusCode == 404 {
                completion(false)
            }
        }
        
        task.resume()
    }
    
    class func starRepository(fullName: String, completion: () -> ()) {
        let urlString = "\(githubAPIURL)/repositories?client_id=\(githubClientID)&client_secret=\(githubClientSecret)&access_token=\(githubAccessToken)"
        guard let url = NSURL(string: urlString) else { assertionFailure("Invalid URL"); return }
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            completion()
        }
        
        task.resume()
    }
    
    class func unstarRepository(fullName: String, completion: () -> ()) {
        let urlString = "\(githubAPIURL)/repositories?client_id=\(githubClientID)&client_secret=\(githubClientSecret)&access_token=\(githubAccessToken)"
        guard let url = NSURL(string: urlString) else { assertionFailure("Invalid URL"); return }
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "DELETE"
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            completion()
        }
        
        task.resume()
    }
}

