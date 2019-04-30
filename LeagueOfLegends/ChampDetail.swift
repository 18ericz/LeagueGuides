//
//  ChampDetail.swift
//  LeagueOfLegends
//
//  Created by 18ericz on 4/28/19.
//  Copyright © 2019 18ericz. All rights reserved.
//

import Foundation 
import Alamofire
import SwiftyJSON

class ChampDetail { 
    var name = ""
    var imageURL = ""
    var calling = ""
    var health = 0.0
    var attackDamage = 0.0
    var armor = 0.0
    var magicResist = 0.0
    var apiURL = ""
    var difficulty = 0
    

    
    
    func getChampionDetail(completed: @escaping () -> () ) {
        Alamofire.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                    self.health = json["data"][self.name]["stats"]["hp"].doubleValue
                    self.attackDamage = json["data"][self.name]["stats"]["attackdamage"].doubleValue
                    self.armor = json["data"][self.name]["stats"]["armor"].doubleValue
                    self.magicResist = json["data"][self.name]["stats"]["spellblock"].doubleValue
                    self.imageURL = "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(self.name)_0.jpg"
                    self.calling = json["data"][self.name]["title"].stringValue
                    self.difficulty = (json["data"][self.name]["info"]["difficulty"].intValue)/2
            case .failure(let error):
                print("ERROR: \(error.localizedDescription) failed to get data from url \(self.apiURL)")
            }
            completed()
        }
        
}

}
