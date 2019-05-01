//
//  DetailViewController.swift
//  LeagueOfLegends
//
//  Created by 18ericz on 4/28/19.
//  Copyright © 2019 18ericz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var callingLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!
    @IBOutlet weak var MRLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var championImageView: UIImageView!
    @IBOutlet weak var difficultyLevel: UIImageView!
    @IBOutlet weak var reviewButton: UIBarButtonItem!
    @IBOutlet weak var reviewTableView: UITableView!
    
    
    

    var champion: Champion!
    var review: Review!
    var reviews: Reviews!
    
    
    
    var name = ""
    var apiURL = ""
    var champDetail = ChampDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        nameLabel.text = champDetail.name
        champDetail.getChampionDetail {
            self.updateUserInterface()
        }
        reviews = Reviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.reviewTableView.reloadData()
        reviews.loadData(reviews: reviews) {
            self.reviewTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "AddReview":
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.viewControllers.first as! ReviewTableViewController
            destination.review = review
            if let selectedIndexPath = reviewTableView.indexPathForSelectedRow{
                reviewTableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        case "ShowReview":
            let destination = segue.destination as! ReviewTableViewController
            destination.review = review

            let selectedIndexPath = reviewTableView.indexPathForSelectedRow!
            destination.review = reviews.reviewArray[selectedIndexPath.row]
        default:
            print("ERROR Did not have a segue in spotData")
        }
    }
    
    
    func updateUserInterface() {    
        healthLabel.text = "\(champDetail.health)"
        armorLabel.text = "\(champDetail.armor)"
        MRLabel.text = "\(champDetail.magicResist)"
        damageLabel.text = "\(champDetail.attackDamage)"
        callingLabel.text = "\(champDetail.calling)"
        difficultyLevel.image = UIImage(named: "\(champDetail.difficulty)-star")
        
        
        guard let url = URL(string: champDetail.imageURL) else {return}
        do {
            let data = try Data(contentsOf: url)
            championImageView.image = UIImage(data: data)
            
        } catch {
            print("COULD NOT LOAD IMAGE")
        }
    }
    
    @IBAction func reviewButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddReview", sender: nil)
    }
    

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! DetailTableViewCell
        cell.review = reviews.reviewArray[indexPath.row]
        return cell
    }
    
    
}
