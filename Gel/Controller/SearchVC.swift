//
//  SearchVC.swift
//  Gel
//
//  Created by Admin on 2.02.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit
import Alamofire
import RxCocoa
import RxSwift

class SearchVC: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var SearchTf: RoundedBorderTextView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSearchField()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        SearchTf.delegate = self
    }
    
    func bindSearchField(){
        let searchResultsObservalbe = SearchTf.rx.text
            .orEmpty.debounce(0.5, scheduler: MainScheduler.instance)
            .map {
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            }
            .flatMap { (q) -> Observable<[Repo]> in
                if q == "" {
                    return Observable<[Repo]>.just([])
                } else {
                    let url = searchUrl + q + starsDescendinSegment
                    var searchRepos = [Repo]()
                    
                    return URLSession.shared.rx.json(url: URL(string: url)!).map {
                        let results = $0 as AnyObject
                        let items = results.object(forKey: "items") as? [Dictionary<String, Any>] ?? []
                        for item in items {
                            guard let name = item["name"] as? String,
                            let description = item["description"] as? String,
                            let language = item["language"] as? String,
                            let repoUrl = item["html_url"] as? String,
                            let forksCount = item["forks_count"] as? Int else { break }
                            let repo = Repo(image: UIImage(named: "search")!, name: name, description: description, numberOfForks: forksCount, language: language, numberOfContributors: 0, repoUrl: repoUrl)
                            searchRepos.append(repo)
                        }
                        return searchRepos
                    }
                }
            }
            .observeOn(MainScheduler.instance)
        searchResultsObservalbe.bind(to: tableView.rx.items(cellIdentifier: "SearchCell")) {
            (row, repo: Repo, cell: SearchCell) in
                cell.configCell(repo: repo)
            }.disposed(by: disposeBag)
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchCell else { return }
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        return true
    }
}
