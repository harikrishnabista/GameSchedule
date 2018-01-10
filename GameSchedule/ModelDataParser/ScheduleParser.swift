//
//  ScheduleParser.swift
//  GameSchedule
//
//  Created by Hari Krishna Bista on 1/7/18.
//  Copyright © 2018 yinzcam. All rights reserved.
//

import UIKit

class ScheduleParser:NSObject,XMLParserDelegate {

    var gameSections = Array<GameSection>()
    
    var currentGameSection:GameSection!
    
    var xmlParser:XMLParser?
    
    var homeTeam:Team!
    
    var opponent:Team!
    var date:GameDate!
    
    var gameType:String?
    
    var Id:String?
    var Week:String?
    var Label:String?
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
    
    func getGameSchedule(scheduleData:Data) -> Array<GameSection>? {
        xmlParser = XMLParser(data: scheduleData)
        xmlParser?.delegate = self
        xmlParser?.parse()
        
        return gameSections
    }
    
    //XMLParserDelegate delegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "GameSection" {
            self.currentGameSection = GameSection(sectionTitle: attributeDict["Heading"] ?? "")
        }
        
        if elementName == "Team" {
            homeTeam = Team()
            homeTeam.TriCode = attributeDict["TriCode"] ?? ""
            homeTeam.FullName = attributeDict["FullName"] ?? ""
            homeTeam.Name = attributeDict["Name"] ?? ""
            homeTeam.City = attributeDict["City"] ?? ""
            homeTeam.Record = attributeDict["Record"] ?? ""
        }

        if elementName == "Opponent" {
            opponent = Team()
            opponent.TriCode = attributeDict["TriCode"] ?? ""
            opponent.FullName = attributeDict["FullName"] ?? ""
            opponent.Name = attributeDict["Name"] ?? ""
            opponent.City = attributeDict["City"] ?? ""
            opponent.Record = attributeDict["Record"] ?? ""
        }
        
        if elementName == "Date" {
            date = GameDate()
            date.Numeric = attributeDict["Numeric"] ?? ""
            date.Text = attributeDict["Text"] ?? ""
            date.Time = attributeDict["Time"] ?? ""
            date.Timestamp = attributeDict["Timestamp"] ?? ""
        }
        
        if elementName == "Game" {
            Week = attributeDict["Week"] ?? ""
            Label = attributeDict["Label"] ?? ""
            
            gameType = attributeDict["Type"] ?? ""
            Id = attributeDict["Id"] ?? ""
            
            Home = attributeDict["Home"] ?? ""
            Radio = attributeDict["Radio"] ?? ""
            Venue = attributeDict["Venue"] ?? ""
            Result = attributeDict["Result"] ?? ""
            WLT = attributeDict["WLT"] ?? ""
            GameState = attributeDict["GameState"] ?? ""
            Quarter = attributeDict["Quarter"] ?? ""
            
            HomeScore = attributeDict["HomeScore"] ?? ""
            AwayScore = attributeDict["AwayScore"] ?? ""
            
            Down = attributeDict["Down"] ?? ""
            Label = attributeDict["Label"] ?? ""
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "GameSection" {
            self.gameSections.append(self.currentGameSection)
        }
        
        if elementName == "Game",let id = self.Id, let opponent = self.opponent, let homeTeam = self.homeTeam {
            
            let aGame = Game(Id: id, homeTeam: homeTeam, opponent: opponent, gameDate: self.date)
            
            aGame.gameType = gameType
            aGame.Week = Week
            aGame.Label = Label
            aGame.Home = Home
            aGame.TV = TV
            aGame.Radio = Radio
            aGame.Venue = Venue
            aGame.Result = Result
            aGame.WLT = WLT
            aGame.GameState = GameState
            aGame.Quarter = Quarter
            aGame.HomeScore = HomeScore
            aGame.AwayScore = AwayScore
            aGame.Down = Down
            
            self.currentGameSection.games.append(aGame)
        }
    }
}
