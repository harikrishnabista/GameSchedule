//
//  Extensions.swift
//  GameSchedule
//
//  Created by Hari Krishna Bista on 1/10/18.
//  Copyright © 2018 yinzcam. All rights reserved.
//

import UIKit

extension UIView {
    func showLoading(message:String) {
        
        let loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width:0, height: 0));
        loadingView.alpha = 0.0;
        
        self.addSubview(loadingView);
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false;
        
        loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true;
        loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true;
        loadingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        self.layoutIfNeeded();
        
        if(message.isEmpty){
            loadingView.loadingMessage.isHidden = true;
        }else{
            loadingView.loadingMessage.text = message;
        }
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            loadingView.alpha = 1;
        }, completion: nil);
        
        // register device orientation notification
        NotificationCenter.default.addObserver(
            self, selector:#selector(self.rotated),name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil);
    }
    
    func showLoadingWithoutMiddleDarkView() {
        let loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height));
        //        loadingView.center = self.center;
        
        loadingView.loadingMessage.text = "";
        loadingView.centerViewContainer.backgroundColor = UIColor.clear;
        
        
        loadingView.alpha = 0.0;
        self.addSubview(loadingView);
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            loadingView.alpha = 0.3;
        }, completion: nil);
        
        // register device orientation notification
        NotificationCenter.default.addObserver(
            self, selector:#selector(self.rotated),name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil);
    }
    
    func showLoading() {
        showLoading(message: "Please Wait...");
    }
    
    func hideLoading() {
        
        DispatchQueue.main.async {
            for item in self.subviews {
                if let loadingView = item as? LoadingView {
                    
                    UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
                        loadingView.alpha = 0.0;
                    }, completion: { (finished: Bool) in
                        loadingView.removeFromSuperview();
                    });
                }
            }
        }
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange,object: nil);
    }
    
    @objc func rotated(){
        for item in self.subviews {
            if let loadingView = item as? LoadingView {
                
                let newFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height);
                
                loadingView.frame = newFrame;
            }
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
