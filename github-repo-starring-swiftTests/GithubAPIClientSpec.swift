//
//  GithubAPIClientSpec.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import github_repo_starring_swift
class GithubAPIClientSpec: QuickSpec {
    
    var starred = false
    
    override func spec() {
        
        guard let path = NSBundle(forClass: self.dynamicType).pathForResource("repositories", ofType: "json") else { print("error getting the path"); return }
        
        guard let data = NSData(contentsOfFile: path) else { print("error getting data"); return }
        let repositoryArray = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
        
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
        
        describe("getRepositories") {
            it("should get the proper repositories from Github") {
                waitUntil(action: { (done) in
                    GithubAPIClient.getRepositoriesWithCompletion({ (repos) in
                        
                        expect(repos).toNot(beNil())
                        expect(repos.count).to(equal(2))
                        expect(repos).to(equal(repositoryArray! as? NSArray))
                        done()
                        
                    })
                })
            }
        }
        
        describe("checkIfRepositoryIsStarred") {
            it("should respond false if the given repo is not starred") {
                OHHTTPStubs.stubRequestsPassingTest({ (request) -> Bool in
                    return(request.URL?.host == "api.github.com" && request.URL?.path == "/user/starred/wycats/merb-core")
                    
                }) { (request) -> OHHTTPStubsResponse in
                    return OHHTTPStubsResponse(fileAtPath: OHPathForFileInBundle("not_starred.json", NSBundle(forClass: self.dynamicType))!, statusCode: 404, headers: ["Content-Type" : "application/json"])

                }
                waitUntil(action: { (done) in
                    GithubAPIClient.checkIfRepositoryIsStarred("wycats/merb-core", completion: { (starred) in
                        expect(starred).to(beFalsy())
                        done()
                    })
                })
            }
            
            it("should respond true if the given repo is starred") {
                OHHTTPStubs.stubRequestsPassingTest({ (request) -> Bool in
                    return(request.URL?.host == "api.github.com" && request.URL?.path == "/user/starred/wycats/merb-core")
                    
                }) { (request) -> OHHTTPStubsResponse in
                    return OHHTTPStubsResponse(data: NSData(), statusCode: 204, headers: nil)
                    
                }
                waitUntil(action: { (done) in
                    GithubAPIClient.checkIfRepositoryIsStarred("wycats/merb-core", completion: { (starred) in
                        expect(starred).to(beTruthy())
                        done()
                    })
                })
            }
        }
        
            
            
        
        
    }
}
