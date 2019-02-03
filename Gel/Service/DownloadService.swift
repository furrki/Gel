//
//  DownloadService.swift
//  Gel
//
//  Created by Admin on 3.02.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
class DownloadService {
    static let instance = DownloadService()
    func trendingReposDictArr(finish: @escaping (_ repos: [Dictionary<String, Any>]) -> ()){
        var trendingReposArr = [Dictionary<String, Any>]()
        Alamofire.request(trendingRepoUrl).responseJSON { (res) in
            guard let json = res.result.value as? Dictionary<String, Any> else { return }
            guard let repoDictArray = json["items"] as? [Dictionary<String, Any>] else { return }
            for repoDict in repoDictArray {
                if trendingReposArr.count <= 9 {
                    guard
                        let name = repoDict["name"] as? String,
                        let desc = repoDict["description"] as? String,
                        let contributorsUrl = repoDict["contributors_url"] as? String,
                        let numberOfForks = repoDict["forks_count"] as? Int,
                        let lang = repoDict["language"] as? String,
                        let repoUrl = repoDict["html_url"] as? String,
                        let owner = repoDict["owner"] as? Dictionary<String, Any>,
                        let avatarUrl = owner["avatar_url"] as? String
                        else {
                            break
                            
                    }
                    let repoDict: Dictionary<String, Any> =
                        [
                            "name": name,
                            "description": desc,
                            "forks_count": numberOfForks,
                            "language": lang,
                            "html_url": repoUrl,
                            "contributors_url": contributorsUrl,
                            "avatar_url": avatarUrl,
                            
                            ]
                    trendingReposArr.append(repoDict)
                } else {
                    
                }
            }
            finish(trendingReposArr)
        }
    }
    func trendingRepos(completion: @escaping (_ repos: [Repo]) -> ()) {
        var repos = [Repo]()
        trendingReposDictArr { (dicts) in
            for dict in dicts {
                self.decodeRepo(fromDict: dict, completion: {
                    (repo) in
                    repos.append(repo)
                    
                    completion(repos)
                })
            }
        }
    }
    func decodeRepo(fromDict dict: Dictionary<String, Any>, completion: @escaping (_ repo: Repo) -> ()) {
        let avatarUrl = dict["avatar_url"] as! String
        let name = dict["name"] as! String
        let desc = dict["description"] as! String
        let contributorsUrl = dict["contributors_url"] as! String
        let numberOfForks = dict["forks_count"] as! Int
        let lang = dict["language"] as! String
        let numberOfContributors = 0
        let repoUrl = dict["html_url"] as! String
        
        downloadImageFor(url: avatarUrl) { (img) in
            self.contributorsDataFor(url: contributorsUrl, completion: { (contributors) in
                let repo = Repo(image: img, name: name, description: desc, numberOfForks: numberOfForks, language: lang, numberOfContributors: numberOfContributors, repoUrl: repoUrl)
                completion(repo)
            })
        }
    }
    func downloadImageFor(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        Alamofire.request(url).responseImage {
            (img) in
            guard let image = img.result.value else { return }
            completion(image)
        }
    }
    func contributorsDataFor(url: String, completion: @escaping (_ contributors: Int) -> ()){
        Alamofire.request(url).responseJSON { (res) in
            guard let json = res.result.value as? [Dictionary<String, Any>] else { return }
            if !json.isEmpty {
                let contributions = json.count
                completion(contributions)
            }
        }
    }
}

