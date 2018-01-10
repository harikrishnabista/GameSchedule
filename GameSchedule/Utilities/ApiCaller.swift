//
//  ApiCaller.swift
//  GameSchedule
//
//  Created by Hari Krishna Bista on 1/6/18.
//  Copyright © 2018 yinzcam. All rights reserved.
//

import UIKit

class ApiCaller {
    
    weak var delegate:ScheduleViewController?
    
    init(delegate:ScheduleViewController) {
        self.delegate = delegate
    }
    
    func getImageFrom(url:URL, completion:@escaping (_ image:UIImage?) -> Void) -> URLSessionTask? {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, resp, err) in
            DispatchQueue.main.async {
                if err == nil, let data = data {
                    completion(UIImage.init(data: data))
                }else{
                    completion(nil)
                }
            }
        })
        
        task.resume()
        
        return task
    }
    
    //    func getDataFromUrl(url:URL, completion:@escaping (_ data:Data?, _ resp:URLResponse?, _ err:Error?) -> Void) {
    func getDataFromUrl(url:URL){
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, resp, err) in
            
            DispatchQueue.main.async {
                self.delegate?.scheduleUpdated(data: data, resp: resp, err: err)
            }
        })
        
        task.resume()
    }
}

