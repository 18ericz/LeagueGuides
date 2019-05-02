//
//  ReviewTableViewController.swift
//  LeagueOfLegends
//
//  Created by 18ericz on 4/28/19.
//  Copyright © 2019 18ericz. All rights reserved.
//

import UIKit
import Firebase

class ReviewTableViewController: UITableViewController {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UITextView!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIButton!
    
    var champion: Champion!
    var review: Review!
    var reviewTitle: String!
    var reviewDescription: String!
    var reviewReviews: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        review = Review()
        emailLabel.text = Auth.auth().currentUser?.email
        updateUserInterface()
    }

    func updateUserInterface(){
        emailLabel.text = review.email
        print("**** \(reviewTitle)")
        reviewTitleLabel.text = reviewTitle

        enableDisableSaveButton()
        reviewLabel.text = reviewReviews

        if review.reviewUserID == Auth.auth().currentUser?.email {
            self.navigationItem.leftItemsSupplementBackButton = false
            saveBarButton.title = "update"
            deleteButton.isHidden = false
        } else{
            cancelBarButton.title = ""
            saveBarButton.title = ""
            emailLabel.text = "\(review.reviewUserID)"
                
            }
        }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {


            navigationController?.popViewController(animated: true)
        }
        
    }
    func enableDisableSaveButton() {
        if reviewTitleLabel.text != "" {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        review.title = reviewTitleLabel.text!
        review.reviews = reviewLabel.text!
        review.saveData(review: review) { (success) in
            if success {
                self.leaveViewController()
            } else {
                print("ERROR")
            }
        }
        // Data could not be parsed through to view controllers..
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        review.deleteData(review: review) { (success) in
            if success {
                self.leaveViewController()
            } else {
                print("ERROR")
            }
        }
    }
    @IBAction func reviewTitleChanged(_ sender: Any) {
        enableDisableSaveButton()
    }
    @IBAction func returnTitleDonePressed(_ sender: UITextField) {
    }
}
