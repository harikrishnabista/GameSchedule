//
//  Team.swift
//  GameSchedule
//
//  Created by Hari Krishna Bista on 1/7/18.
//  Copyright © 2018 yinzcam. All rights reserved.
//

import UIKit

class Team {
    var TriCode:String = ""
    var FullName:String = ""
    var Name:String = ""
    var City:String = ""
    var Record:String = ""
    
    func getLogoUrl() -> String {
        return "https://s3.amazonaws.com/yc-app-resources/nfl/logos/nfl_\(self.TriCode.lowercased())_light.png"
    }
    
    func getLogo(completion:@escaping (_ image:UIImage?,_ url:String) -> Void) -> URLSessionTask? {
        if let url = URL(string:self.getLogoUrl()) {
            print("downloading image from: \(url.absoluteString)")
//            return ApiCaller(delegate:self).getImageFrom(url: url) { (img) in
//                completion(img, url.absoluteString)
//            }
        }
        
        return nil
    }
}
