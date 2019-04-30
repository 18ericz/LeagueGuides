//
//  Champion.swift
//  LeagueOfLegends
//
//  Created by 18ericz on 4/28/19.
//  Copyright © 2019 18ericz. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class Champion {
    struct ChampionData {
        var name: String
        var title: String
        var difficulty: Int
    }
    
    var championArray: [ChampionData] = []
    var apiURL = "https://ddragon.leagueoflegends.com/cdn/6.24.1/data/en_US/champion.json"
    
    var champName =  ["Aatrox","Ahri","Akali","Alistar","Amumu","Anivia","Annie","Ashe","AurelionSol","Azir","Bard","Blitzcrank","Brand","Braum","Caitlyn","Camille","Cassiopeia","Chogath","Corki","Darius","Diana","DrMundo","Draven","Ekko","Elise","Elise","Evelynn","Ezreal","FiddleSticks","Fiora","Fizz","Galio","Gangplank","Garen","Gnar","Gragas","Graves","Hecarim","Heimerdinger","Illaoi","Irelia","Ivern","Janna","JarvanIV","Jax","Jayce","Jhin","Jinx","Kalista","Karma","Karthus","Kassadin","Kassadin","Kayle","Kennen","Khazix","Kindred","Kled","KogMaw","Leblanc","LeeSin","Leona","Lissandra","Lucian","Lulu","Lux","Malphite","Malzahar","Maokai","MasterYi","MissFortune","Mordekaiser","Morgana","Nami","Nasus","Nautilus","Nidalee","Nocturne","Nunu","Olaf","Orianna","Pantheon","Poppy","Quinn","Rammus","RekSai","Renekton","Rengar","Riven","Rumble","Ryze","Sejuani","Shaco","Shen","Shyvana","Singed","Sion","Sivir","Skarner","Sona","Soraka","Swain","Syndra","TahmKench","Taliyah","Talon","Taric","Teemo","Thresh","Tristana","Trundle","Tryndamere","TwistedFate","Twitch","Udyr","Urgot","Varus","Vayne","Veigar","Velkoz","Vi","Viktor","Vladimir","Volibear","Warwick","MonkeyKing","Xerath","XinZhao","Yasuo","Yorick","Zac","Zed","Ziggs","Zilean","Zyra"]
    // var champName used because there was an unexepected error regarding index of the JSON URL //
    
    func getChampion(completed: @escaping () -> () ) {
        Alamofire.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                let numberOfChampions = json["data"].count
                for index in 0...numberOfChampions {
                    let name = json["data"][self.champName[index]]["name"].stringValue
                    let title = json["data"][self.champName[index]]["title"].stringValue
                    let difficulty = (json["data"][self.champName[index]]["info"]["difficulty"].intValue)
                    self.championArray.append(ChampionData(name: name, title: title, difficulty: difficulty))
                }
            case .failure(let error):
                print("ERROR: \(error.localizedDescription) failed to get data from url \(self.apiURL)")
            }
            completed()
        }
    }
    
    
}
