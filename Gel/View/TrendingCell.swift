//
//  TrendingCell.swift
//  Gel
//
//  Created by Admin on 3.02.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TrendingCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescLabel: UILabel!
    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var numberOfForksLabel: UILabel!
    @IBOutlet weak var numberOfContributorsLabel: UILabel!
    @IBOutlet weak var viewReadmeButton: RoundedBorderButton!
    @IBOutlet weak var langLabel: UILabel!
    
    private var repoUrl: String?
    var disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(repo: Repo){
        
        repoNameLabel.text = repo.name
        repoDescLabel.text = repo.description
        repoImage.image = repo.image
        numberOfForksLabel.text = String(repo.numberOfForks)
        numberOfContributorsLabel.text = String(repo.numberOfContributors)
        langLabel.text = repo.language
        repoUrl = repo.repoUrl
        viewReadmeButton.rx.tap.subscribe(onNext: {
            self.window?.rootViewController?.presentSFSafariVCFor(url: self.repoUrl!)
        }).disposed(by: disposeBag)
    }
    
    override func layoutSubviews() {
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowRadius = 5.0
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
