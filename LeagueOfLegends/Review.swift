//
//  Review.swift
//  LeagueOfLegends
//
//  Created by 18ericz on 4/28/19.
//  Copyright © 2019 18ericz. All rights reserved.
//

import Foundation
import Firebase


class Review {
    var email: String
    var title: String
    var reviews: String
    var reviewUserID: String
    var documentID: String
    
    var dictionary: [String: Any]{
        return ["email": email, "title": title, "review": reviews, "reviewUserID":
            reviewUserID, "documentID": documentID]
    }
    
    init (email: String, title: String, review: String, reviewUserID: String, documentID: String){
        self.email = email
        self.title = title
        self.reviews = review
        self.reviewUserID = reviewUserID
        self.documentID = documentID
        
    }
    
    convenience init(dictionary: [String: Any]) {
        let email = dictionary["email"] as! String? ?? ""
        let title = dictionary["title"] as! String? ?? ""
        let review = dictionary["review"] as! String? ?? ""
        let reviewUserID = dictionary["reviewUserID"] as! String? ?? ""
        self.init(email: email, title: title, review: review, reviewUserID: reviewUserID, documentID: "")
    }
    
    convenience init() {
        let currentUserID = Auth.auth().currentUser?.email ?? "unknown User"
        self.init(email: "", title: "", review: "", reviewUserID: currentUserID, documentID: "")
    }
    func saveData(completed: @escaping(Bool) -> ()) {
        let db = Firestore.firestore()
        
        guard let reviewUserID = (Auth.auth().currentUser?.uid) else {
            return completed(false)
        }
        self.reviewUserID = reviewUserID
        let dataToSave = self.dictionary
        if self.documentID != ""{
            let ref = db.collection("reviews").document(self.documentID)
            ref.setData(dataToSave) {(error) in
                if let error = error {
                    completed(false)
                } else {
                    completed(true)
                }
                
            }
        }else {
            var ref: DocumentReference? = nil
            ref = db.collection("reviews").addDocument(data: dataToSave) { error in
                if let error = error {
                    completed(false)
                } else {
                    self.documentID = ref!.documentID
                    completed(true)
                }
            }
            
        }
        
    }
    
    
    




//class Review {
//    var email: String
//    var title: String
//    var review: String
//    var documentID: String
//    var dictionary: [String: Any] {
//        return ["email": email, "title":title, "review": review, "documentID": documentID]
//    }
//
//    init(email: String, title: String, review: String, documentID: String){
//        self.email = email
//        self.title = title
//        self.review = review
//        self.documentID = documentID
//    }
//
//    convenience init() {
//        let currentUserID = Auth.auth().currentUser?.email ?? "Unknown"
//
//        self.init(email: currentUserID, title: "", review: "", documentID: "")
//    }
//
//
//    func saveData(champion: Champion , completed: @escaping (Bool) -> ()) {
//        let db = Firestore.firestore()
//
//        let dataToSave = self.dictionary
//        if self.documentID != "" {
//            let ref = db.collection("Review").document(self.documentID).collection("reviews").document(self.documentID)
//            ref.setData(dataToSave) { (error) in
//                if let error = error {
//                    print("ERROR UPDATING DOCUMENT")
//                    completed(false)
//                } else {
//                    print("DOCUMENT UPDATED")
//                    completed(true)
//                }
//            }
//        } else{
//            var ref: DocumentReference? = nil
//            ref = db.collection("Review").document(self.documentID).collection("reviews").addDocument(data: dataToSave){error in
//                if let error = error {
//                    print("Error creating new document")
//                    completed(false)
//
//                } else {
//                    print("New document created")
//                    completed(true)
//                }
//            }
//        }
//    }

}
