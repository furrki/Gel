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

    let refreshControl = UIRefreshControl()
    var dataSource = PublishSubject<[Repo]>()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Repos From Github 🐰",
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1),
                                                                         NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!])
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        fetchData()
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "TrendingCell")){
            (row, repo: Repo, cell: TrendingCell) in 
                cell.configCell(repo: repo)
            
            }.disposed(by: disposeBag)
        
    }
    
    @objc func fetchData(){
        DownloadService.instance.trendingRepos { (repos) in
            self.dataSource.onNext(repos)
            self.refreshControl.endRefreshing()
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

