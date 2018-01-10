//
//  ScheduledTableViewCell.swift
//  GameSchedule
//
//  Created by Hari Krishna Bista on 1/7/18.
//  Copyright © 2018 yinzcam. All rights reserved.
//

import UIKit

class ScheduledTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var lblOpponentName: UILabel!
    @IBOutlet weak var imgHomeLogo: UIImageView!
    @IBOutlet weak var imgOpponentLogo: UIImageView!
    @IBOutlet weak var lblWeek: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTv: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    var downloadTask:URLSessionTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
