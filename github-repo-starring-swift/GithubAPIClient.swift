//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    
    
    
    class func checkIfRepositoryIsStarred(completion: (NSArray) -> ()) {
    let urlString = "\(Secrets.githubAPIURL)/repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
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
    
    
    class func checkIfRepositoryIsStarred(fullName: String, completion:(Bool) -> ()) {
        let urlString = "\(Secrets.starAPIURL)/\(fullName)" 
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        
        let request = NSMutableURLRequest(URL: unwrappedURL)
        request.HTTPMethod = "GET"
        request.addValue("\(Secrets.personalToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard let responseValue = response as? NSHTTPURLResponse
                else { fatalError("this did not work")
            }
            if responseValue.statusCode == 204 {
                print("repo was starred")
                completion(true)
            }else if responseValue.statusCode == 404 {
                print("repo was not starred")
                completion(false)
            }else {
                print("other status code \(responseValue.statusCode)")
            }
        }
        task.resume()
    }
    
    class func starRepository(fullName: String, completion:() -> ()){
        
        let urlString = "\(Secrets.starAPIURL)/\(fullName)" //from secret
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        
        let request = NSMutableURLRequest(URL: unwrappedURL)
        request.HTTPMethod = "PUT"
        request.addValue("\(Secrets.personalToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard let responseValue = response as? NSHTTPURLResponse else {
                fatalError("this did not work")
            }
            if responseValue.statusCode == 204 {
                print("I am starring repository")
                completion()
            }else {
                print("Star Repo : other status code \(responseValue.statusCode)")
            }
        }
        task.resume()
    }
    
    class func unStarRepository(fullName: String, completion:() -> ()){
        
        let urlString = "\(Secrets.starAPIURL)/\(fullName)" //from secret
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        
        let request = NSMutableURLRequest(URL: unwrappedURL)
        request.HTTPMethod = "DELETE"
        request.addValue("\(Secrets.personalToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard let responseValue = response as? NSHTTPURLResponse else {
                fatalError("this did not work")
            }
            if responseValue.statusCode == 204 {
                print("I am unstarring repository")
                completion()
            }else {
                print("Unstar Repo : other status code \(responseValue.statusCode)")
            }
        }
        task.resume()
    }
}
    
    


