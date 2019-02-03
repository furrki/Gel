//
//  SearchCell.swift
//  Gel
//
//  Created by Admin on 3.02.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoDescLabel: UILabel!
    @IBOutlet weak var LanguageLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    public private(set) var repoUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 15.0
    }
    func configCell(repo: Repo){
        repoNameLbl.text = repo.name
        repoDescLabel.text = repo.description
        img.image = repo.image
        forksCountLabel.text = String(repo.numberOfForks)
        LanguageLabel.text = repo.language
        repoUrl = repo.repoUrl
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
