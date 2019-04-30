//
//  SplashScreenViewController.swift
//  LeagueOfLegends
//
//  Created by 18ericz on 4/28/19.
//  Copyright © 2019 18ericz. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var instructionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 4) {
            self.instructionLabel.textColor = UIColor.white
            
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        
        performSegue(withIdentifier: "ShowTableView", sender: nil)
    }
    
}
