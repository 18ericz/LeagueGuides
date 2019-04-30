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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        review = Review()
        emailLabel.text = Auth.auth().currentUser?.email
        updateUserInterface()
    }

    func updateUserInterface(){
        emailLabel.text = review.reviewUserID
        reviewTitleLabel.text = review.title
        reviewLabel.text = review.reviews
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {


            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        review.saveData { success in
            if success {
                self.leaveViewController()
            }else {
                print("*** ERROR COULDNT LEAVE VIEW CONTROLLER")
            }
        }
        // Data could not be parsed through to view controllers..
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {	
    }
    @IBAction func reviewTitleChanged(_ sender: Any) {
    }
    @IBAction func returnTitleDonePressed(_ sender: UITextField) {
    }
}
