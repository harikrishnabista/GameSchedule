//
//  GameViewController.swift
//  GameSchedule
//
//  Created by Hari Krishna Bista on 1/9/18.
//  Copyright © 2018 yinzcam. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var blockView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Game"
        
        self.blockView.showLoading()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
