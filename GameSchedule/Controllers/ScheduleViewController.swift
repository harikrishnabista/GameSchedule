//
//  ScheduleViewController.swift
//  GameSchedule
//
//  Created by Hari Krishna Bista on 1/6/18.
//  Copyright © 2018 yinzcam. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SlidePanelCallBack {
    
    //required delegate method for SlidePanelCallBack
    func SlidePanelJustHidden() {
        print("just hidden")
    }

    var gameSections = Array<GameSection>()

    @IBOutlet weak var tableView: UITableView!
    
    var logoCache:[String:UIImage] = [:]
    
    var menuView:MenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let btnMenu: UIButton = UIButton(type: UIButtonType.custom)
        btnMenu.setImage(UIImage(named: "iconMenu"), for: .normal)
        
        btnMenu.addTarget(self, action: #selector(btnMenuTapped), for: .touchDown)
        
        let barButton = UIBarButtonItem(customView: btnMenu)
        
        navigationItem.leftBarButtonItem = barButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(btnRefreshTapped))
        
        self.view.backgroundColor = UIColor.white
        self.title = "SCHEDULE"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let finalCell = UINib(nibName: "FinalTableViewCell", bundle: nil)
        self.tableView.register(finalCell, forCellReuseIdentifier: "FinalTableViewCell")
        
        let scheduledCell = UINib(nibName: "ScheduledTableViewCell", bundle: nil)
        self.tableView.register(scheduledCell, forCellReuseIdentifier: "ScheduledTableViewCell")
        
        let byeCell = UINib(nibName: "ByeTableViewCell", bundle: nil)
        self.tableView.register(byeCell, forCellReuseIdentifier: "ByeTableViewCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 196
        
        loadGameSchedule()
    }
    
    @objc func btnRefreshTapped() {
        loadGameSchedule()
    }
    
    @objc func btnMenuTapped() {
        menuView =  MenuView(delegate: self);
        menuView.ShowSlidePanel(direction: .left, offsetPercentage: 30, animated: true);
    }
    
    func loadGameSchedule() {
        let urlComp = URLComponents(string: Constants.HTTP.scheduleUrl)
        
        if let url = urlComp?.url {
            self.view.showLoading()
            ApiCaller(delegate: self).getDataFromUrl(url: url)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.gameSections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: Double(tableView.bounds.width), height: Double(tableView.sectionHeaderHeight)))
        
        headerView.backgroundColor = Constants.Color.headerGrayBg
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textColor = Constants.Color.themeGrayColor
        
        label.text = gameSections[section].sectionTitle
        
        headerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        
        label.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        headerView.layoutIfNeeded();
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameSections[section].games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let game = gameSections[indexPath.section].games[indexPath.row]
        
        if let gameType = game.gameScheduleType {
            switch gameType {
            case GameType.scheduled:
                return getScheduledCell(game: game, indexPath: indexPath)
            case GameType.final:
                return getFinalCell(game: game, indexPath: indexPath)
            default:
                return getByeCell(game: game, indexPath: indexPath)
            }
        }
        
        return getByeCell(game: game, indexPath: indexPath)
    }
    
    func getByeCell(game:Game, indexPath:IndexPath) -> ByeTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ByeTableViewCell", for: indexPath) as! ByeTableViewCell
        if let label = game.Label {
            cell.lblWeek.text = "Week \(label)"
        }
        
        return cell
    }
    
    func getScheduledCell(game:Game,indexPath:IndexPath) -> ScheduledTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduledTableViewCell", for: indexPath) as! ScheduledTableViewCell
        
        cell.lblTeamName.text = game.homeTeam.Name
        cell.lblOpponentName.text = game.opponent.Name
        
        cell.lblOpponentName.text = game.opponent.Name
        cell.lblWeek.text = game.Week
        
        cell.lblDate.text = game.getDisplayDate()
        
        cell.imgHomeLogo.image = UIImage(named:"noImage")
        cell.imgOpponentLogo.image = UIImage(named:"noImage")
        
        cell.lblTv.text = game.TV
        cell.lblTime.text = game.date.Time
        
        if let cacheImg = self.logoCache[game.homeTeam.getLogoUrl()] {
            cell.imgHomeLogo.image = cacheImg
        }else{
            cell.downloadTask = game.homeTeam.getLogo { (img,url) in
                if let img = img {
                    self.logoCache[url] = img
                    cell.imgHomeLogo.image = img
                }
            }
        }
        
        if let cacheImg = self.logoCache[game.opponent.getLogoUrl()] {
            cell.imgOpponentLogo.image = cacheImg
        }else{
            cell.downloadTask = game.opponent.getLogo { (img, url) in
                if let img = img {
                    self.logoCache[url] = img
                    cell.imgOpponentLogo.image = img
                }
            }
        }
        
        return cell
    }
    
    func getFinalCell(game:Game,indexPath:IndexPath) -> FinalTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinalTableViewCell", for: indexPath) as! FinalTableViewCell
        
        cell.lblTeamName.text = game.homeTeam.Name
        cell.lblOpponentName.text = game.opponent.Name
        
        if let homeScore = game.HomeScore, homeScore.isEmpty == false {
            cell.lblHomeScore.text = homeScore
        }else{
            cell.lblHomeScore.text = "n/a"
        }
        
        if let awayScore = game.AwayScore, awayScore.isEmpty == false {
            cell.lblOpponentScore.text = awayScore
        }else{
            cell.lblOpponentScore.text = "n/a"
        }
        
        cell.lblGameType.text = game.getGameType()
        
        cell.lblOpponentName.text = game.opponent.Name
        cell.lblWeek.text = game.Week
        
        cell.lblDate.text = game.getDisplayDate()
        
        cell.imgHomeLogo.image = UIImage(named:"noImage")
        cell.imgOpponentLogo.image = UIImage(named:"noImage")
        
        if let cacheImg = self.logoCache[game.homeTeam.getLogoUrl()] {
            cell.imgHomeLogo.image = cacheImg
        }else{
            cell.downloadTask = game.homeTeam.getLogo { (img,url) in
                if let img = img {
                    self.logoCache[url] = img
                    cell.imgHomeLogo.image = img
                }
            }
        }
        
        if let cacheImg = self.logoCache[game.opponent.getLogoUrl()] {
            cell.imgOpponentLogo.image = cacheImg
        }else{
            cell.downloadTask = game.opponent.getLogo { (img, url) in
                if let img = img {
                    self.logoCache[url] = img
                    cell.imgOpponentLogo.image = img
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FinalTableViewCell, let task = cell.downloadTask {
            if task.state == URLSessionTask.State.running{
                print("downloading image cancelled because no more need to show.")
                task.cancel()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let gameViewCon = GameViewController.init(nibName: "GameViewController", bundle: nil);
        
        self.navigationController?.pushViewController(gameViewCon, animated: true)
    }
    
    // delegate call back method when asyc call ends this function gets called
    func scheduleUpdated(data:Data?, resp:URLResponse?, err:Error?) {
        
        self.view.hideLoading()
        
        if let data = data {
            if let gSchedule = ScheduleParser().getGameSchedule(scheduleData: data) {
                self.gameSections = gSchedule
                self.tableView.reloadData()
            }
        }
    }
}
