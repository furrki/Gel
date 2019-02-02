//
//  TrendingsVC.swift
//  Gel
//
//  Created by Admin on 2.02.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

class TrendingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath) as? TrendingCell else { return UITableViewCell() }
        let repo = Repo(image: UIImage(named: "search")!,  name: "Swift", description: "Apple's Programming Lang.", numberOfForks: 388, language: "Swift", numberOfContributors: 1453, repoUrl: "http://furrki.com")
        cell.configCell(repo: repo)
        return cell
    }

}

