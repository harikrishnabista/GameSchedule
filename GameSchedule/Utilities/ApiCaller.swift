//
//  ApiCaller.swift
//  GameSchedule
//
//  Created by Hari Krishna Bista on 1/6/18.
//  Copyright © 2018 yinzcam. All rights reserved.
//

import UIKit

class ApiCaller {
    
    var session:URLSession?
    init() {
        let configuration = URLSessionConfiguration.default;
        self.session = URLSession(configuration: configuration);
    }
    
    func getImageFrom(url:URL, completion:@escaping (_ image:UIImage?) -> Void) -> URLSessionTask? {
        let task = self.session?.dataTask(with: url, completionHandler: { (data, resp, err) in
            DispatchQueue.main.async {
                if err == nil, let data = data {
                    completion(UIImage.init(data: data))
                }else{
                    completion(nil)
                }
            }
        })
        
        task?.resume()
        
        return task
    }
    
    func getDataFromUrl(url:URL, completion:@escaping (_ data:Data?, _ resp:URLResponse?, _ err:Error?) -> Void) {
        let task = self.session?.dataTask(with: url, completionHandler: { (data, resp, err) in
            DispatchQueue.main.async {
                completion(data, resp, err)
            }
        })
        
        task?.resume()
    }
}
