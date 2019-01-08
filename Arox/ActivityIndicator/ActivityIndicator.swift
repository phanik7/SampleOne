//
//  ActivityIndicator.swift
//  Arox
//
//  Created by Vivek Dharmani on 07/01/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
class ActivityInd{
    var activityIndicatorView:NVActivityIndicatorView!
    static let sharedActivity = ActivityInd()
    func startAnimating(view:UIView,color:UIColor){
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: (view.bounds.size.width/2)-50, y: (view.bounds.size.height/2)-50, width: 100, height: 100), type: .ballClipRotate, color: color, padding: 15)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    func stopAnimating(){
        activityIndicatorView.stopAnimating()
    }
}
