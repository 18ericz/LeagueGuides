//
//  Reviews.swift
//  LeagueOfLegends
//
//  Created by 18ericz on 4/29/19.
//  Copyright © 2019 18ericz. All rights reserved.
//

import Foundation
import Firebase

class Reviews{
    var reviewArray = [Review]()
    var db: Firestore!
    
    init(){
        db = Firestore.firestore()
    }
    func loadData(completed: @escaping ()->()) {
        db.collection("reviews").addSnapshotListener {(querySnapshot, error) in
            guard error == nil else {
                print("ERROR")
                return completed()
            }
            self.reviewArray = []
            for document in querySnapshot!.documents {
                let review = Review(dictionary: document.data())
                review.documentID = document.documentID
                self.reviewArray.append(review)
            }
            completed()
        }
    }
}
