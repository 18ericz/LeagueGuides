//
//  DetailTableViewCell.swift
//  LeagueOfLegends
//
//  Created by 18ericz on 4/29/19.
//  Copyright © 2019 18ericz. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    var review: Review! {
        didSet {
            titleLabel.text = review.title
            reviewLabel.text = review.reviews
        }
    }
}
