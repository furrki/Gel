//
//  TrendingsVC.swift
//  Gel
//
//  Created by Admin on 2.02.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingsVC: UIViewController, UITableViewDelegate {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = PublishSubject<[Repo]>()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "TrendingCell")){
            (row, repo: Repo, cell: TrendingCell) in 
                cell.configCell(repo: repo)
            
            }.disposed(by: disposeBag)
        
    }
    func fetchData(){
        DownloadService.instance.trendingRepos { (repos) in
            self.dataSource.onNext(repos)
        }
    }
    
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath) as? TrendingCell else { return UITableViewCell() }
        let repo = Repo(image: UIImage(named: "search")!,  name: "Swift", description: "Apple's Programming Lang.", numberOfForks: 388, language: "Swift", numberOfContributors: 1453, repoUrl: "http://furrki.com")
        cell.configCell(repo: repo)
        return cell
    }*/

}

