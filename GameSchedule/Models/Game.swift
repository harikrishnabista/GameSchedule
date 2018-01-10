//
//  Game.swift
//  GameSchedule
//
//  Created by Hari Krishna Bista on 1/6/18.
//  Copyright © 2018 yinzcam. All rights reserved.
//

import UIKit

class GameDate {
    var Numeric:String = ""
    var Text:String = ""
    var Time:String = ""
    var Timestamp:String = ""
}

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum GameType:String {
    case scheduled = "S"
    case final = "F"
    case bye = "B"
    case na = "n/a"
}

class Game {
    var Id:String
    var opponent:Team
    var homeTeam:Team
    var date:GameDate
    
    var Week:String?
    var Label:String?
    var gameType:String? {
        didSet {
            self.gameScheduleType = GameType.init(rawValue: self.gameType ?? "B")
        }
    }
    
    var  gameScheduleType:GameType?
    
    var Home:String?
    var TV:String?
    var Radio:String?
    var Venue:String?
    var Result:String?
    var WLT:String?
    var GameState:String?
    var Quarter:String?
    var AwayScore:String?
    var HomeScore:String?
    var Down:String?
    
    var tickets:Array<Ticket>?
    
    init(Id:String,homeTeam:Team,opponent:Team, gameDate:GameDate) {
        self.Id = Id
        self.homeTeam = homeTeam
        self.opponent = opponent
        self.date = gameDate
    }
    
    func getDisplayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self.date.Numeric)
        
        dateFormatter.dateFormat = "EE, MMM dd"
        
        if let date = date {
            return dateFormatter.string(from: date)
        }
        
        return "n/a"
    }
    
    func getGameType() -> String {
        if let gameType = self.gameType {
            if let type = GameType.init(rawValue: gameType) {
                return String(describing: type).uppercased()
            }
        }
        
        return "n/a"
    }
    
//    func getGameType() -> GameType? {
//
//    }
    
//    func getHomeLogoUrl() -> String {
//        return "https://s3.amazonaws.com/yc-app-resources/nfl/logos/nfl_\(self.opponent.TriCode.lowercased())_light.png"
//    }
    
//    func getOpponentLogo(completion:@escaping (_ image:UIImage?,_ url:String) -> Void) {
//        if let url = URL(string:self.getHomeLogo(completion: <#T##(UIImage?, String) -> Void#>)) {
//            print("getting image from: \(url.absoluteString)")
//            ApiCaller().getImageFrom(url: url) { (img) in
//               completion(img, url.absoluteString)
//            }
//        }
//    }
//
    
}
