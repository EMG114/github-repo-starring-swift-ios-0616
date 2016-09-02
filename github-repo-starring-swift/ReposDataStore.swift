//
//  ReposDataStore.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    private init() {}
    
    var repositories:[GithubRepository] = []
    
    func getRepositoriesWithCompletion(completion: () -> ()) {
        GithubAPIClient.checkIfRepositoryIsStarred{ (reposArray) in
            self.repositories.removeAll()
            for dictionary in reposArray {
                guard let repoDictionary = dictionary as? NSDictionary else { fatalError("Object is invalid type") }
                let repository = GithubRepository(dictionary: repoDictionary)
                self.repositories.append(repository)
                
            }
            completion()
        }
    }

    
    func toggleStarStatusForRepository(repository: GithubRepository, completion: () -> ()){
        GithubAPIClient.checkIfRepositoryIsStarred(repository.fullName) { (starred) in
            if starred == true {
                GithubAPIClient.unStarRepository(repository.fullName, completion: {
                    print("Unstarring")
                    completion()
                })
            } else {
                GithubAPIClient.starRepository(repository.fullName, completion: {
                    print("Starring")
                    completion()
                })
            }
        }
    }
    
    
}
