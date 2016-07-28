//
//  GithubRepositorySpec.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Quick
import Nimble

@testable import github_repo_starring_swift

class GithubRepositorySpec: QuickSpec {
    
    override func spec() {
        describe("GithubRepository") {
            describe("init(dictionary:)") {
                let repoDictionary = [  "html_url":"https://github.com",
                                        "full_name":"test/test",
                                        "id":2 ]
                
                let correctID = repoDictionary["id"] as! NSNumber
                let correctURL = repoDictionary["html_url"] as! String
                let correctName = repoDictionary["full_name"] as! String
                
                it("should create a Github Repository object with the correct data") {
                    let repo = GithubRepository(dictionary: repoDictionary)
                    expect(repo.repositoryID).to(equal(correctID.stringValue))
                    expect(repo.htmlURL).to(equal(NSURL(string: correctURL)))
                    expect(repo.fullName).to(equal(correctName))
                }
            }
        }
    }

}
